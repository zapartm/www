using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WWW;

namespace zad3_przygotowanie
{
    public partial class Shop : System.Web.UI.Page
    {
        protected List<Tuple<Product, int>> productsInCart;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.QueryString["action"];
            int id = -1;

            switch (action)
            {
                case "AddToCart":
                    id = int.Parse(Request.QueryString["productId"]);
                    int quantity = int.Parse(Request.QueryString["quantity"]);
                    productsInCart = Session["productsInCart"] as List<Tuple<Product, int>>;
                    if (productsInCart == null)
                        productsInCart = new List<Tuple<Product, int>>();

                    int index = -1;
                    if((index = productsInCart.FindIndex(p => p.Item1.Id == id)) > -1)
                    {
                        productsInCart[index] = new Tuple<Product, int>(productsInCart[index].Item1, productsInCart[index].Item2 + quantity);
                    }
                    else
                    {
                        Product p = Warehouse.PRODUCTS.First(pp => pp.Id == id);
                        productsInCart.Add(new Tuple<Product, int>(p, quantity));
                    }
                    Session["productsInCart"] = productsInCart;
                    break;

                case "clearTheCart":
                    Session["productsInCart"] = null;
                    break;
                case "RemoveFromTheCart":
                    productsInCart = Session["productsInCart"] as List<Tuple<Product, int>>;
                    if (productsInCart == null)
                    {
                        break;
                    }
                    id = int.Parse(Request.QueryString["productId"]);
                    productsInCart.RemoveAll(pp => pp.Item1.Id == id);
                    break;
            }
        }


    }
}