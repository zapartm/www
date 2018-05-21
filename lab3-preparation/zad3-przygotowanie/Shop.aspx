<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="zad3_przygotowanie.Shop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>WWW - Task 3</title>
	<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
	<!-- Remove style="display: none;" and add it to #products and #cart to show order summary -->
    <!-- Order summary should be visible only when user checkout the order -->
    <div id="order" style="display: none;">
        <h2>Order Summary:</h2>
        <table>
            <tr>
                <th>Product</th>
                <th>Price per product</th>
                <th>Quantity</th>
            </tr>
			<!-- Iterate through all products in order START -->
           
                <%--<td><!-- TODO: Product name --></td>
                <td><!-- TODO: Product price --> zł</td>
                <td><!-- TODO: Product quantity --></td>--%>
			<!-- Iterate through all products in order END -->
        </table>
        <p><strong>Total price: </strong><!-- TODO: Total price --> zł</p>
        <a href="<!-- TODO: Appropriate link -->"><input type="button" value="Create new order"/></a>
    </div>
	
   
     <div id="error" style="display: none;">
        ERROR<!-- Display if error occurs -->
    </div>

    
    <div runat="server" id="products">
        <h2>Products:</h2>
        <!-- Iterate through all products in warehouse START -->
        <%foreach (var v in WWW.Warehouse.PRODUCTS) {%>
        <div class="product">
            <form method="get" action="Shop.aspx">
                <p class="name"><%=v.Name %> <!-- TODO: Product name--></p>
                <p class="price"><strong><%=v.Price %></strong><!-- Product price --> zł</p>
                <span class="quantity"><strong>Quantity: </strong></span><input type="number" id="quantity" name="quantity" value="1" min="1" />
                <input type="hidden" name="action" value="AddToCart" />
                <input type="hidden" name="productId" value="<%=v.Id %>" />
                <input type="submit" value="Add to cart" />
            </form>
        </div>
        <% } %>
        <!-- Iterate through all products in warehouse END -->
    </div>


    <div id="cart">
        <h2>Cart:</h2>

        <%if (productsInCart == null || productsInCart.Count == 0)
            { %>
            <p id="empty_cart_tag">Cart is empty!</p>
        <%}
    else
    { %>
        <!-- Iterate through all products in cart START -->
            <%foreach (var item in productsInCart)
    {%>
                <div class="product">
                    <p class="name"><%=item.Item1.Name %> <!-- TODO: Product name--></p>
                    <p class="price"><strong><%=item.Item1.Price %> </strong><!-- Product price --> zł</p>
                    <p class="quantity">
                        <strong>Quantity: <%=item.Item2 %></strong><!-- Product quantity -->
                        <a href="<!-- TODO: Appropriate link -->"><input type="button" value="+" /></a>
                        <a href="<!-- TODO: Appropriate link -->"><input type="button" value="-" /></a>
                    </p>
                    <form method="get" action="Shop.aspx">
                        <!-- Add some hidden inputs to pass additional data -->
                        <input type="hidden" name="action" value="RemoveFromTheCart" />
                        <input type="hidden" name="productId" value="<%=item.Item1.Id %>" />
                        <input type="submit" value="Remove from cart" />
                    </form>
                </div>
            <%}
    }%>
        <!-- Iterate through all products in cart END -->

        <!-- Show control buttons only when there are some products in the cart -->
        <div class="controlButtons">
            <a href="Shop.aspx?action=clearTheCart"><input type="button" value="ClearCart" /></a>
            <a href="<!-- TODO: Appropriate link -->"><input type="button" value="Checkout" /></a>
        </div>
    </div>
	
</body>
</html>
