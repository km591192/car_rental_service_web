<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>

<html>
<head>
  <title>Forms Authentication - Admin Page</title>
    <link href="App_Themes/AdminHome.css" rel="stylesheet" />
</head>

<script runat="server">

    void Signout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("Admin.aspx");
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        var c1 = Calendar1.SelectedDate.Date;
        var c2 = Calendar2.SelectedDate.Date;
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
        int car_id = Convert.ToInt32(DropDownList1.SelectedItem.Text);
        DataView dv = (DataView)SqlDataSource4.Select(DataSourceSelectArguments.Empty);
        price_per_day = (int)dv.Table.Rows[car_id-1][1];
        Label4.Text = "Total price = " + (day_count*price_per_day).ToString();
    }


    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        String n = TextBox1.Text;
        String s = TextBox2.Text;
        String t = TextBox3.Text;
        String dl = TextBox4.Text;
        if (n == "" || t == "" || dl == "") return;
        String query = "INSERT INTO client(Name,Surname,Telephone,dl_num) VALUES('" + n + "','" + s + "','" + t + "','" + dl + "')";
        SqlDataSource1.InsertCommand = query;
        SqlDataSource1.Insert();
        TextBox1.Text = "";
        TextBox2.Text = "";
        TextBox3.Text = "";
        TextBox4.Text = "";
    }

    protected void Button8_Click(object sender, EventArgs e)
    {
        var c1 = Calendar3.SelectedDate.Date;
        var c2 = Calendar4.SelectedDate.Date;
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
        int car_id = Convert.ToInt32(DropDownList2.SelectedItem.Text);
        DataView dv = (DataView)SqlDataSource6.Select(DataSourceSelectArguments.Empty);
        int row_num = 0;
        for (int i = 0; i < (int)dv.Table.Rows.Count; i++)
        {
            if (car_id == (int)dv.Table.Rows[i][0])
                row_num = i;
        }
        price_per_day = (int)dv.Table.Rows[row_num][2];
        Label4.Text = "Total price = " + (day_count*price_per_day).ToString();
        int cl_id = Convert.ToInt32(DropDownList3.SelectedValue);
        string strstart = c1.ToString("yyyy-MM-dd HH:mm:ss.fff");
        string strend = c2.ToString("yyyy-MM-dd HH:mm:ss.fff");
        int totalprice = day_count * price_per_day;

        int flag = 1;
        string rn_str = "";
        DataView dv2 = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
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
                        (c2 >= (DateTime)dv2.Table.Rows[Convert.ToInt32(arr_rn[i])][1] && c2 <= (DateTime)dv2.Table.Rows[Convert.ToInt32(arr_rn[i])][2]))
                    flag = 0;
        }
        String query = "INSERT INTO la(date_start,date_end,total_price,cl_id,car_id) VALUES('" + strstart + "','" + strend +"'," + totalprice + "," + cl_id + "," + car_id + ")";
        if (flag == 1)
        {
            SqlDataSource2.InsertCommand = query;
            SqlDataSource2.Insert();
        }
        if (flag == 0)
        {
            Label8.Text = "CAR IN RENT !!! PLEASE, CHOOSE ANOTHER ONE.";
        }
    }


    protected void Button7_Click(object sender, EventArgs e)
    {
        int model_id = Convert.ToInt32(DropDownList4.SelectedValue);
        String reg_num = TextBox5.Text;
        String query = "INSERT INTO car(reg_num,model_id) VALUES('" + reg_num + "'," + model_id + ")";
        SqlDataSource5.InsertCommand = query;
        SqlDataSource5.Insert();
        TextBox5.Text = "";
    }


    protected void Button9_Click(object sender, EventArgs e)
    {
        String c = TextBox6.Text;
        String m = TextBox7.Text;
        String p = TextBox8.Text;
        String col = TextBox9.Text;
        String kpp = TextBox10.Text;
        String producer = DropDownList5.SelectedValue;
        if (m == "" || p == "") return;
        String query = "INSERT INTO model(class,model,price_per_day,color,kpp,producer_id) VALUES('" + c + "','" + m + "'," + p + ",'" + col + "','" + kpp + "','" + producer +"')";
        SqlDataSource10.InsertCommand = query;
        SqlDataSource10.Insert();
        TextBox6.Text = "";
        TextBox7.Text = "";
        TextBox8.Text = "";
        TextBox9.Text = "";
        TextBox10.Text = "";
    }

    protected void Button10_Click(object sender, EventArgs e)
    {
         String n = TextBox11.Text;
        String c = TextBox12.Text;
        if (n == "") return;
        String query = "INSERT INTO producer(name,country) VALUES('" + n + "','" + c + "')";
        SqlDataSource12.InsertCommand = query;
        SqlDataSource12.Insert();
        TextBox11.Text = "";
        TextBox12.Text = "";
    }
</script>

<body>
  <form id="Form1" runat="server">
    <div class="">
  <h3 style="font-family: Arial, Helvetica, sans-serif; color: #0066FF; text-decoration: unset">
    <asp:Button ID="Submit1" OnClick="Signout_Click" 
       Text="EXIT" runat="server" style="text-align: right" ForeColor="#3366FF" /> 
          &nbsp;
      &nbsp;
      &nbsp;
      Admin page</h3>
      <h3>
          <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="2" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" CancelButtonText="Cancel" FinishCompleteButtonText="Finish" FinishPreviousButtonText="Previous" StartNextButtonText="Next" StepNextButtonText="Next" StepPreviousButtonText="Previous">
              <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
              <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
              <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
              <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
              <StepStyle Font-Size="0.8em" ForeColor="#333333" />
              <WizardSteps>
                  <asp:WizardStep runat="server" title="Client">
                      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT * FROM [client]" DeleteCommand="DELETE FROM [client] WHERE [id] = @id" InsertCommand="INSERT INTO [client] ([id], [Name], [Surname], [Telephone], [dl_num]) VALUES (@id, @Name, @Surname, @Telephone, @dl_num)
" ProviderName="<%$ ConnectionStrings:CarrentdbConnectionString1.ProviderName %>" UpdateCommand="UPDATE [client] SET [Name] = @Name, [Surname] = @Surname, [Telephone] = @Telephone, [dl_num] = @dl_num WHERE [id] = @id
">
                          <InsertParameters>
                              <asp:Parameter Name="id" />
                              <asp:Parameter Name="Name" />
                              <asp:Parameter Name="Surname" />
                              <asp:Parameter Name="Telephone" />
                              <asp:Parameter Name="dl_num" />
                          </InsertParameters>
                          <UpdateParameters>
                              <asp:Parameter Name="id" />
                              <asp:Parameter Name="Telephone" />
                              <asp:Parameter Name="Name" />
                              <asp:Parameter Name="Surname" />
                              <asp:Parameter Name="dl_num" />
                          </UpdateParameters>
                      </asp:SqlDataSource>
                      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" EmptyDataText="Нет записей для отображения." AutoGenerateDeleteButton="True" AutoGenerateEditButton="True" AutoGenerateSelectButton="True">
                          <Columns>
                              <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" InsertVisible="False" />
                              <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                              <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                              <asp:BoundField DataField="Telephone" HeaderText="Telephone" SortExpression="Telephone" />
                              <asp:BoundField DataField="dl_num" HeaderText="dl_num" SortExpression="dl_num" />
                          </Columns>
                      </asp:GridView>
                      <p>

                          &nbsp;Name: &nbsp;<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>

                      </p>
                      <p>
                          Surname:
                          <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                      </p>
                      <p>
                          Telephone:
                          <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                      </p>
                      <p>
                          Driving License number:
                          <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                      </p>
                          &nbsp;
                      <p>
                          <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Add client" Width="127px" />
                      </p>
                  </asp:WizardStep>
                  <asp:WizardStep runat="server" title="Lease agreement">
                      <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" DeleteCommand="DELETE FROM [la] WHERE [id] = @id" InsertCommand="INSERT INTO [la] ([id], [date_start], [date_end], [total_price], [cl_id], [car_id]) VALUES (@id, @date_start, @date_end, @total_price, @cl_id, @car_id)" ProviderName="<%$ ConnectionStrings:CarrentdbConnectionString1.ProviderName %>" SelectCommand="SELECT [id], [date_start], [date_end], [total_price], [cl_id], [car_id] FROM [la]" UpdateCommand="UPDATE [la] SET [date_start] = @date_start, [date_end] = @date_end, [total_price] = @total_price, [cl_id] = @cl_id, [car_id] = @car_id WHERE [id] = @id">
                          <DeleteParameters>
                              <asp:Parameter Name="id" Type="Int32" />
                          </DeleteParameters>
                          <InsertParameters>
                              <asp:Parameter Name="id" Type="Int32" />
                              <asp:Parameter DbType="Date" Name="date_start" />
                              <asp:Parameter DbType="Date" Name="date_end" />
                              <asp:Parameter Name="total_price" Type="Int32" />
                              <asp:Parameter Name="cl_id" Type="Int32" />
                              <asp:Parameter Name="car_id" Type="Int32" />
                          </InsertParameters>
                          <UpdateParameters>
                              <asp:Parameter DbType="Date" Name="date_start" />
                              <asp:Parameter DbType="Date" Name="date_end" />
                              <asp:Parameter Name="total_price" Type="Int32" />
                              <asp:Parameter Name="cl_id" Type="Int32" />
                              <asp:Parameter Name="car_id" Type="Int32" />
                              <asp:Parameter Name="id" Type="Int32" />
                          </UpdateParameters>
                      </asp:SqlDataSource>
                      <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource2" EmptyDataText="Нет записей для отображения.">
                          <Columns>
                              <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                              <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" />
                              <asp:BoundField DataField="date_start" HeaderText="date_start" SortExpression="date_start" />
                              <asp:BoundField DataField="date_end" HeaderText="date_end" SortExpression="date_end" />
                              <asp:BoundField DataField="total_price" HeaderText="total_price" SortExpression="total_price" />
                              <asp:BoundField DataField="cl_id" HeaderText="cl_id" SortExpression="cl_id" />
                              <asp:BoundField DataField="car_id" HeaderText="car_id" SortExpression="car_id" />
                          </Columns>
                      </asp:GridView>
                      &nbsp;&nbsp;

                      <br />
                      <br />
                      <asp:GridView ID="GridView6" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource6" EmptyDataText="Нет записей для отображения.">
                          <Columns>
                              <asp:BoundField DataField="Car_id" HeaderText="Car_id" ReadOnly="True" SortExpression="Car_id" InsertVisible="False" />
                              <asp:BoundField DataField="Model_id" HeaderText="Model_id" SortExpression="Model_id" InsertVisible="False" ReadOnly="True" />
                              <asp:BoundField DataField="price_per_day" HeaderText="price_per_day" SortExpression="price_per_day" />
                              <asp:BoundField DataField="producer_id" HeaderText="producer_id" SortExpression="producer_id" />
                              <asp:BoundField DataField="model" HeaderText="model" SortExpression="model" />
                          </Columns>
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT car.id AS Car_id, model.id AS Model_id, model.price_per_day, model.producer_id, model.model FROM producer INNER JOIN model ON producer.name = model.producer_id INNER JOIN car ON model.id = car.model_id"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT * FROM [client]"></asp:SqlDataSource>
                      <br />
                      <br />
                      Car id:
                      <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource6" DataTextField="Car_id" DataValueField="Car_id">
                      </asp:DropDownList>
                      <br />
                      Client id:
                      <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource7" DataTextField="Telephone" DataValueField="id">
                      </asp:DropDownList>
                      <br />
                      Date start:<asp:Calendar ID="Calendar3" runat="server"></asp:Calendar>
                      Data_end:<asp:Calendar ID="Calendar4" runat="server"></asp:Calendar>
                      <br />
                      <asp:Button ID="Button8" runat="server" OnClick="Button8_Click" Text="Add la" />
                      <asp:Label ID="Label8" runat="server"></asp:Label>
                      <br />
                      <br />
                      <br />
                      <br />

                  </asp:WizardStep>
                  <asp:WizardStep runat="server" Title="Car">
                       &nbsp;&nbsp;
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT * FROM [car]" DeleteCommand="DELETE FROM [car] WHERE [id] = @id" InsertCommand="INSERT INTO [car] ([id], [reg_num], [model_id]) VALUES (@id, @reg_num, @model_id)
" ProviderName="<%$ ConnectionStrings:CarrentdbConnectionString1.ProviderName %>" UpdateCommand="UPDATE [car] SET [reg_num] = @reg_num, [model_id] = @model_id WHERE [id] = @id
" >
                        <InsertParameters>
                            <asp:Parameter Name="id" />
                            <asp:Parameter Name="reg_num" />
                            <asp:Parameter Name="model_id" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="reg_num" />
                            <asp:Parameter Name="model_id" />
                            <asp:Parameter Name="id" />
                        </UpdateParameters>
                       </asp:SqlDataSource>
                     <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource5" EmptyDataText="Нет записей для отображения." AutoGenerateDeleteButton="True" AutoGenerateEditButton="True" AutoGenerateSelectButton="True">
                          <Columns>
                              <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                              <asp:BoundField DataField="reg_num" HeaderText="reg_num" SortExpression="reg_num" />
                              <asp:BoundField DataField="model_id" HeaderText="model_id" SortExpression="model_id" />
                          </Columns>
                      </asp:GridView>
                      <br />
                      <br />
                      <asp:GridView ID="GridView7" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource8" EmptyDataText="Нет записей для отображения.">
                          <Columns>
                              <asp:BoundField DataField="Car_id" HeaderText="Car_id" InsertVisible="False" ReadOnly="True" SortExpression="Car_id" />
                              <asp:BoundField DataField="Model_id" HeaderText="Model_id" InsertVisible="False" ReadOnly="True" SortExpression="Model_id" />
                              <asp:BoundField DataField="producer_id" HeaderText="producer_id" SortExpression="producer_id" />
                              <asp:BoundField DataField="model" HeaderText="model" SortExpression="model" />
                              <asp:BoundField DataField="kpp" HeaderText="kpp" SortExpression="kpp" />
                              <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
                          </Columns>
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT car.id AS Car_id, model.id AS Model_id, model.producer_id, model.model, model.kpp, model.color FROM producer INNER JOIN model ON producer.name = model.producer_id INNER JOIN car ON model.id = car.model_id"></asp:SqlDataSource>
                      <br />
                      <br />
                      Reg number:&nbsp;
                      <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                      <br />
                      <br />
                      Model_id:<asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource8" DataTextField="Model_id" DataValueField="Model_id">
                      </asp:DropDownList>
                      <br />
                      <br />
                      <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Add cars" />
                  </asp:WizardStep>
                  <asp:WizardStep runat="server" Title="Model">
                      <asp:GridView ID="GridView9" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource10" EmptyDataText="Нет записей для отображения.">
                          <Columns>
                              <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                              <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                              <asp:BoundField DataField="class" HeaderText="class" SortExpression="class" />
                              <asp:BoundField DataField="model" HeaderText="model" SortExpression="model" />
                              <asp:BoundField DataField="price_per_day" HeaderText="price_per_day" SortExpression="price_per_day" />
                              <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
                              <asp:BoundField DataField="kpp" HeaderText="kpp" SortExpression="kpp" />
                              <asp:BoundField DataField="producer_id" HeaderText="producer_id" SortExpression="producer_id" />
                          </Columns>
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" DeleteCommand="DELETE FROM [model] WHERE [id] = @id" InsertCommand="INSERT INTO [model] ([class], [model], [price_per_day], [color], [kpp], [producer_id]) VALUES (@class, @model, @price_per_day, @color, @kpp, @producer_id)" SelectCommand="SELECT [id], [class], [model], [price_per_day], [color], [kpp], [producer_id] FROM [model]" UpdateCommand="UPDATE [model] SET [class] = @class, [model] = @model, [price_per_day] = @price_per_day, [color] = @color, [kpp] = @kpp, [producer_id] = @producer_id WHERE [id] = @id">
                          <DeleteParameters>
                              <asp:Parameter Name="id" Type="Int32" />
                          </DeleteParameters>
                          <InsertParameters>
                              <asp:Parameter Name="class" Type="String" />
                              <asp:Parameter Name="model" Type="String" />
                              <asp:Parameter Name="price_per_day" Type="Int32" />
                              <asp:Parameter Name="color" Type="String" />
                              <asp:Parameter Name="kpp" Type="String" />
                              <asp:Parameter Name="producer_id" Type="String" />
                          </InsertParameters>
                          <UpdateParameters>
                              <asp:Parameter Name="class" Type="String" />
                              <asp:Parameter Name="model" Type="String" />
                              <asp:Parameter Name="price_per_day" Type="Int32" />
                              <asp:Parameter Name="color" Type="String" />
                              <asp:Parameter Name="kpp" Type="String" />
                              <asp:Parameter Name="producer_id" Type="String" />
                              <asp:Parameter Name="id" Type="Int32" />
                          </UpdateParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT [name] FROM [producer]"></asp:SqlDataSource>
                      <br />
                      Class:&nbsp;
                      <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                      <br />
                      Model:
                      <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                      <br />
                      Price per day:
                      <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                      <br />
                      Color:
                      <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
                      <br />
                      KPP:
                      <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
                      <br />
                      Producer_id:
                      <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDataSource11" DataTextField="name" DataValueField="name">
                      </asp:DropDownList>
                      <br />
                      <br />
                      <br />
                      <asp:Button ID="Button9" runat="server" OnClick="Button9_Click" Text="Add model" />
                  </asp:WizardStep>
                  <asp:WizardStep runat="server" Title="Producer">
                      <asp:GridView ID="GridView10" runat="server" AutoGenerateColumns="False" DataKeyNames="name" DataSourceID="SqlDataSource12" EmptyDataText="Нет записей для отображения." AllowPaging="True" AllowSorting="True">
                          <Columns>
                              <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                              <asp:BoundField DataField="name" HeaderText="name" ReadOnly="True" SortExpression="name" />
                              <asp:BoundField DataField="country" HeaderText="country" SortExpression="country" />
                          </Columns>
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSource12" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" DeleteCommand="DELETE FROM [producer] WHERE [name] = @name" InsertCommand="INSERT INTO [producer] ([name], [country]) VALUES (@name, @country)" SelectCommand="SELECT [name], [country] FROM [producer]" UpdateCommand="UPDATE [producer] SET [country] = @country WHERE [name] = @name">
                          <DeleteParameters>
                              <asp:Parameter Name="name" Type="String" />
                          </DeleteParameters>
                          <InsertParameters>
                              <asp:Parameter Name="name" Type="String" />
                              <asp:Parameter Name="country" Type="String" />
                          </InsertParameters>
                          <UpdateParameters>
                              <asp:Parameter Name="country" Type="String" />
                              <asp:Parameter Name="name" Type="String" />
                          </UpdateParameters>
                      </asp:SqlDataSource>
                      <br />
                      Producer name:<asp:TextBox ID="TextBox11" runat="server"></asp:TextBox>
                      <br />
                      Country:
                      <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox>
                      <br />
                      <br />
                      <asp:Button ID="Button10" runat="server" OnClick="Button10_Click" Text="Add producer" />
                  </asp:WizardStep>
                  <asp:WizardStep runat="server" Title="Calculate total price">
                      <asp:GridView ID="GridView4" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource4" EmptyDataText="Нет записей для отображения.">
                          <Columns>
                              <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" />
                              <asp:BoundField DataField="price_per_day" HeaderText="price_per_day" SortExpression="price_per_day" />
                              <asp:BoundField DataField="producer_id" HeaderText="producer_id" SortExpression="producer_id" />
                              <asp:BoundField DataField="model" HeaderText="model" SortExpression="model" />
                          </Columns>
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT model.id, model.price_per_day, model.producer_id, model.model FROM producer INNER JOIN model ON producer.name = model.producer_id"></asp:SqlDataSource>
                      <br />
                      <asp:Label ID="Label1" runat="server" Text="Model id:"></asp:Label>
                      &nbsp;&nbsp;
                      <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource4" DataTextField="id" DataValueField="id">
                      </asp:DropDownList>
                      <br />
                      <asp:Label ID="Label2" runat="server" Text="Date start:"></asp:Label>
                      <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                      <asp:Label ID="Label3" runat="server" Text="Date end:"></asp:Label>
                      <asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
                      <br />
                      <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Total price" />
                      <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                      <br />
                      &nbsp;&nbsp;
                  </asp:WizardStep>
              </WizardSteps>
          </asp:Wizard>
      </h3>
      <h3>
          &nbsp;</h3>
      <h3>
&nbsp;&nbsp;
          &nbsp;&nbsp;
          </h3>
      <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
      <p>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <p>
          &nbsp;<p>
          &nbsp;<p>
&nbsp;&nbsp;
      <p>
          &nbsp;&nbsp;
          <p>
          &nbsp;
          </p>
      </div>
    </form>
</body>
</html>