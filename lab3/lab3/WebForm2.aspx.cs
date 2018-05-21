using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WWW;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

namespace lab3
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected Travel DetailedTravel;
        protected Bitmap b;
        protected void Page_Load(object sender, EventArgs e)
        {
            string id_str = Request.QueryString["id"];
            if(id_str != null)
            {
                int id = -1;
                if (!int.TryParse(id_str, out id))
                    System.Diagnostics.Debug.WriteLine("cannot parse travel ID");
                DetailedTravel = TravelAgency.TRAVELS.First(t => t.Id == id);

                b = new Bitmap(200, 200);
                Graphics g = Graphics.FromImage(b);
                Color c = Color.FromName(DetailedTravel.Destination.GetDescription());
                using (Brush bb = new SolidBrush(c))
                {
                    g.FillEllipse(bb, 100, 100, 200, 200);
                }
                //b.Save(Context.Response., ImageFormat.MemoryBmp);
            }

        }
    }
}