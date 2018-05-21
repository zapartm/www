<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="lab3.WebForm1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>WWW - Task 3</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
    <div id="error" style="display: none;">
        ERROR<!-- Display if error occurs -->
    </div>

    <!-- Remove style="display: none;" and add it to #travels and #searchBox to show booking summary -->
    <!-- Booking summary should be visible only when user book the travel -->
    
    <div style={display: none} id="travelDetails">
        <p class="title"><!-- TODO: Display booked travel title --></p>
        <table>
            <tr>
                <td><p class="price"><strong>Price: </strong></p></td>
                <td><p class="price"><!-- TODO: Display booked travel price --></p></td>
            </tr>
            <tr>
                <td><p class="destination"><strong>Destination: </strong></p></td>
                <td><p class="destination"><!-- TODO: Display booked travel destination --></p></td>
            </tr>
            <tr>
                <td><p class="description"><strong>Description: </strong></p></td>
                <td><p class="description"><!-- TODO: Display booked travel description --></p></td>
            </tr>
        </table>
        <img src="<!-- TODO: Appropriate link -->" /><br />
        <a href="WebForm1.aspx?action=cancelReservrtion"><input type="button" value="Cancel reservation" /></a>

    </div>
   
    <div id="searchBox">
        <h2>Search:</h2>
        <div style="float: left;">
            <form method="get" action="WebForm1.aspx">
                <table>
                    <tr>
                        <td><label for="priceFrom">Price from: </label></td>
                        <td><input type="number" value="0" min="0" name="priceFrom" /></td>
                    </tr>
                    <tr>
                        <td><label for="priceTo">Price to: </label></td>
                        <td><input type="number" value="9000" min="0" name="priceTo" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="hidden" name="action" value="search" />
                            <input type="submit" value="Search" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <%if (filteredTravels != null){ %>
            <div style="float: left; margin-left: 25px;">
                <!-- Display only when price filter is applied -->
                <div>
                    <strong>Search criteria: </strong><br />
                    <span>Price from: <%=priceFrom %> zł </span><br />
                    <span>Price to: <%=priceTo %> zł </span><br />
                    <a href="WebForm1.aspx?action=clear"><input type="button" value="Clear search" /></a>
                </div>
            </div>
            <div style="clear: both;"></div>
        <%} %>
    </div>
    
    <div id="travels">
        <h2>Travels:</h2>
        <!-- Iterate through all travels in travel agency START -->
        <%if (filteredTravels == null)
            { %>
            <%foreach (var t in WWW.TravelAgency.TRAVELS)
                {%>
                    <div class="travel">
                        <form method="get" action="<!-- TODO: Appropriate link -->">
                            <p class="name"><%=t.Title %></p>
                            <p class="price"><strong>Price: </strong><%=t.Price %> zł</p>
                            <p class="destination"><strong>Destination: </strong><%=t.Destination %></p>
                            <!-- TODO: Add some hidden inputs? -->
                            <a href="WebForm2.aspx?id=<%=t.Id%>"><input type="button" value="Show details" /></a>
                            <input type="hidden" name="booking" value="yes" />
                            <input type="submit" value="Book travel" />
                        </form>
                    </div>
            <%} %>
        <%}
            else
            {%>
           <%foreach (var t in filteredTravels)
               {%>
                    <div class="travel">
                        <form method="get" action="<!-- TODO: Appropriate link -->">
                            <p class="name"><%=t.Title %></p>
                            <p class="price"><strong>Price: </strong><%=t.Price %> zł</p>
                            <p class="destination"><strong>Destination: </strong><%=t.Destination %></p>
                            <!-- TODO: Add some hidden inputs? -->
                            <a href="WebForm2.aspx?id=<%=t.Id%>"><input type="button" value="Show details" /></a>
                            <input type="hidden" name="booking" value="yes" />
                            <input type="submit" value="Book travel" />
                        </form>
                    </div>
            <%} %>

        <%} %>
    </div>
   
</body>
</html>
