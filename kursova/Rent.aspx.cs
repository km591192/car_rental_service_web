using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WS_Mail;


public partial class Rent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MyWS dt = new MyWS();
        DateTime[] dt_arr = dt.GetDateTimes();
        string[] date = dt_arr[1].ToString().Split(' ');
        Label4.Text = date[0];
    }

    MyWS sendmsg = new MyWS();

    protected void Button2_Click(object sender, EventArgs e)
    {
        String n = TextBox1.Text;
        String s = TextBox2.Text;
        String t = TextBox3.Text;
        String dl = TextBox4.Text;
        if (n == "" || t == "" || dl == "") { Label3.Text = "Please. Enter some information in the field."; return; }

        DataView dv3 = (DataView)SqlDataSource4.Select(DataSourceSelectArguments.Empty);
        int row_num1 = -1;
        for (int i = 0; i < dv3.Table.Rows.Count; i++)
        {
            if (TextBox1.Text.Trim().ToString() == (string)dv3.Table.Rows[i][1].ToString().Trim() &&
                TextBox2.Text.Trim().ToString() == (string)dv3.Table.Rows[i][2].ToString().Trim() &&
                TextBox3.Text.Trim().ToString() == (string)dv3.Table.Rows[i][3].ToString().Trim() &&
                TextBox4.Text.Trim().ToString() == (string)dv3.Table.Rows[i][4].ToString().Trim())
                row_num1 = i;
        }
        int cl_id = -1;
        if (row_num1 > -1)
            cl_id = (int)dv3.Table.Rows[row_num1][0];
        String query = "INSERT INTO client(Name,Surname,Telephone,dl_num) VALUES('" + n + "','" + s + "','" + t + "','" + dl + "')";
        if (cl_id > 0)
        {
            Label3.Text = "You are in our database. Your number is:" + cl_id.ToString();
        }
        else
        {
            SqlDataSource4.InsertCommand = query;
            SqlDataSource4.Insert();

            sendmsg.SendEmail("New client", "New client : " + n + " " + s + ". " + "Tel:" + t + ". " + "Dr. license:" + dl);
        }

        TextBox1.Text = "";
        TextBox2.Text = "";
        TextBox3.Text = "";
        TextBox4.Text = "";

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        int cl_id = Convert.ToInt32(DropDownList5.SelectedValue);
        var c1 = Calendar5.SelectedDate.Date;
        var c2 = Calendar6.SelectedDate.Date;
        int day_count = 0;
        int price_per_day = 0;
        System.TimeSpan days = TimeSpan.Zero;
        if (c1 != null && c2 != null)
        {
            days = c2.Subtract(c1);
        }
        string tmp_days = days.ToString();
        string[] tmp_days_arr = tmp_days.Split('.');
        if (c1 != c2 && Convert.ToInt32(tmp_days_arr[0]) > 0)
            day_count = Convert.ToInt32(tmp_days_arr[0]);
        if (c1 == c2) day_count = 1;
        int car_id = Convert.ToInt32(DropDownList3.SelectedItem.Text);
        DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        int row_num = 0;
        for (int i = 0; i < (int)dv.Table.Rows.Count; i++)
        {
            if (car_id == (int)dv.Table.Rows[i][0])
                row_num = i;
        }
        price_per_day = (int)dv.Table.Rows[row_num][6];
        Label2.Text = "Total price = " + (day_count * price_per_day).ToString();

        string strstart = c1.ToString("yyyy-MM-dd HH:mm:ss.fff");
        string strend = c2.ToString("yyyy-MM-dd HH:mm:ss.fff");
        int totalprice = day_count * price_per_day;

        int flag = 1;
        string rn_str = "";
        DataView dv2 = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);
        for (int i = 0; i < (int)dv2.Table.Rows.Count; i++)
        {
            if (car_id == (int)dv2.Table.Rows[i][5])
                rn_str += i.ToString() + " ";
        }
        string[] arr_rn = rn_str.Split(' ');
        for (int i = 0; i < arr_rn.Length; i++)
        {
            if (arr_rn[i] != "")
                if ((c1 >= (DateTime)dv2.Table.Rows[Convert.ToInt32(arr_rn[i])][1] && c1 <= (DateTime)dv2.Table.Rows[Convert.ToInt32(arr_rn[i])][2]) ||
                        (c2 >= (DateTime)dv2.Table.Rows[Convert.ToInt32(arr_rn[i])][1] && c2 <= (DateTime)dv2.Table.Rows[Convert.ToInt32(arr_rn[i])][2]) )
                    flag = 0;
            if ((c1 <= c2 && c1 >= DateTime.Now.Date && c2 >= DateTime.Now.Date) && flag != 0)
                flag = 1;
            else flag = 0;
        }
        String query = "INSERT INTO la(date_start,date_end,total_price,cl_id,car_id) VALUES('" + strstart + "','" + strend + "'," + totalprice + "," + cl_id + "," + car_id + ")";
        if (flag == 1)
        {
            SqlDataSource3.InsertCommand = query;
            SqlDataSource3.Insert();

            sendmsg.SendEmail("New lease agreement ", "New lease agreement : Start: " + strstart + " End: " + strend + ". " + "Total price :" + totalprice + ". " + "Client id :" + cl_id.ToString() + ". Car id: " + car_id.ToString());
        }
        if (flag == 0)
        {
            Label2.Text = "CAR IN RENT !!! PLEASE, CHOOSE ANOTHER ONE. OR ERROR IN DATE";
        }
    }



    protected void Button3_Click(object sender, EventArgs e)
    {
        DataView dv3 = (DataView)SqlDataSource4.Select(DataSourceSelectArguments.Empty);
        int row_num1 = -1;
        for (int i = 0; i < dv3.Table.Rows.Count; i++)
        {
            if (TextBox1.Text != "" && TextBox2.Text != "" && TextBox3.Text != "" && TextBox4.Text != "")
                if (TextBox1.Text.Trim().ToString() == (string)dv3.Table.Rows[i][1].ToString().Trim() &&
                    TextBox2.Text.Trim().ToString() == (string)dv3.Table.Rows[i][2].ToString().Trim() &&
                    TextBox3.Text.Trim().ToString() == (string)dv3.Table.Rows[i][3].ToString().Trim() &&
                    TextBox4.Text.Trim().ToString() == (string)dv3.Table.Rows[i][4].ToString().Trim())
                    row_num1 = i;
        }
        int cl_id = -1;
        if (row_num1 > -1)
            cl_id = (int)dv3.Table.Rows[row_num1][0];
        if (cl_id > 0)
            Label3.Text = "Your number is: " + cl_id.ToString();
        else
            Label3.Text = "Please, enter button Add. You are not in our database.";

    }


    protected void Button4_Click(object sender, EventArgs e)
    {
        Label2.Text = "For show total price choose car id and dates: start  and end";
        var c1 = Calendar5.SelectedDate.Date;
        var c2 = Calendar6.SelectedDate.Date;
        int day_count = 0;
        int price_per_day = 0;
        System.TimeSpan days = TimeSpan.Zero;
        if ((c1 != null && c2 != null) && c1 < c2 && c1 >= DateTime.Now.Date && c2 >= DateTime.Now.Date)
        {
            days = c2.Subtract(c1);
        }
        string tmp_days = days.ToString();
        string[] tmp_days_arr = tmp_days.Split('.');
        if ((c1 != c2) && c1 < c2 && c1 >= DateTime.Now.Date && c2 >= DateTime.Now.Date)
        {
            if (Convert.ToInt32(tmp_days_arr[0]) > 0)
            day_count = Convert.ToInt32(tmp_days_arr[0]);
        }
        if (c1 == c2) day_count = 1;
        int car_id = Convert.ToInt32(DropDownList3.SelectedItem.Text);
        DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        int row_num = 0;
        for (int i = 0; i < (int)dv.Table.Rows.Count; i++)
        {
            if (car_id == (int)dv.Table.Rows[i][0])
                row_num = i;
        }
        price_per_day = (int)dv.Table.Rows[row_num][6];
        Label2.Text = "Total price = " + (day_count * price_per_day).ToString();

    }


}
