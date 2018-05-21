using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WWW;

namespace lab3
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private readonly int PRICE_MAX = 9000;
        private readonly int PRICE_MIN = 0;
        protected List<Travel> filteredTravels;
        protected int priceFrom;
        protected int priceTo;
        protected bool booking;
        protected void Page_Load(object sender, EventArgs e)
        {
            booking = false;
            string action = Request.QueryString["action"];

            if(Request.Cookies["reservation"] != null)
            {
                booking = true;
                return;
            }

            if(Request.QueryString["booking"] == "yes")
            {
                booking = true;
                HttpCookie cookie = new HttpCookie("reservation");
                cookie.Expires = DateTime.Now.AddDays(30d);
                Response.SetCookie(cookie);
                return;
            }

            switch(action)
            {
                case "cancelReservrtion":
                    HttpCookie cookie = new HttpCookie("reservation");
                    cookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.SetCookie(cookie);
                    break;
                case "search":
                    filteredTravels = Session["filteredTravels"] as List<Travel>;
                    if (filteredTravels == null)
                        filteredTravels = new List<Travel>();

                    priceFrom = int.Parse(Request.QueryString["priceFrom"]);
                    priceTo = int.Parse(Request.QueryString["priceTo"]);

                    filteredTravels.Clear();
                    foreach(var t in TravelAgency.TRAVELS)
                    {
                        if(t.Price > priceFrom && t.Price < priceTo)
                        {
                            filteredTravels.Add(t);
                        }
                    }

                    Session["filteredTravels"] = filteredTravels;
                    break;
                case "clear":
                    filteredTravels = null;
                    priceTo = PRICE_MAX;
                    priceFrom = PRICE_MIN;                        
                    break;
                //case "cancelReservrtion":
                //    break;
            }
           
        }
    }
}