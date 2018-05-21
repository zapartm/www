<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="lab3.WebForm2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>WWW - Task 3</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
    <%if (DetailedTravel == null)
        { %>
        <div id="error" style="display: none;">
            ERROR<!-- Display if error occurs -->
        </div>
    <%}
    else
    { %>
        <div id="travelDetails">
            <p class="title"><%=DetailedTravel.Title %></p>
            <table>
                <tr>
                    <td><p class="price"><strong>Price: </strong></p></td>
                    <td><p class="price"><%=DetailedTravel.Price %> zł</p></td>
                </tr>
                <tr>
                    <td><p class="destination"><strong>Destination: </strong></p></td>
                    <td><p class="destination"><%=DetailedTravel.Destination %></p></td>
                </tr>
                <tr>
                    <td><p class="description"><strong>Description: </strong></p></td>
                    <td><p class="description"><%=DetailedTravel.Description %></p></td>
                </tr>
            </table>
            <a href="WebForm1.aspx"><input type="button" value="Back to travels" /></a>
        </div>
    <%} %>
</body>
</html>

