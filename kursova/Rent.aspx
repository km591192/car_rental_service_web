<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Rent.aspx.cs" Inherits="Rent" StylesheetTheme="Main"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        <asp:Label ID="Label4" runat="server" Text="DateTime" style="color: #FFFF99; text-align:left"></asp:Label>
    </h3>
    <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="5" BackColor="#E6E2D8" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="Black" Width="100%" CancelButtonText="Cancel" FinishCompleteButtonText="Finish" FinishPreviousButtonText="Previous" SkipLinkText="Skip navigation link" StartNextButtonText="Next" StepNextButtonText="Next" StepPreviousButtonText="Previous">
        <HeaderStyle BackColor="#666666" BorderColor="#E6E2D8" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
        <NavigationButtonStyle BackColor="White" BorderColor="#C5BBAF" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#1C5E55" />
        <SideBarButtonStyle ForeColor="White" />
        <SideBarStyle BackColor="#1C5E55" Font-Size="0.9em" VerticalAlign="Top" />
        <StepStyle BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderStyle="Solid" BorderWidth="2px" />
        <WizardSteps>
            <asp:WizardStep runat="server" title="Rent a car">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT car.id, model.producer_id, model.class, model.model, model.color, model.kpp, model.price_per_day FROM car INNER JOIN model ON car.model_id = model.id INNER JOIN producer ON model.producer_id = producer.name"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT * FROM [la]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT * FROM [client]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT [id] FROM [client] WHERE (([Name] = @Name) AND ([Surname] = @Surname) AND ([Telephone] = @Telephone) AND ([dl_num] = @dl_num))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TextBox1" Name="Name" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox2" Name="Surname" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox3" Name="Telephone" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox4" Name="dl_num" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                Car number:
                <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource1" DataTextField="id" DataValueField="id">
                </asp:DropDownList>
                <br />
                My number is:
                <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDataSource4" DataTextField="id" DataValueField="id">
                </asp:DropDownList>
                <br />
                Date start:<asp:Calendar ID="Calendar5" runat="server"></asp:Calendar>
                Data_end:<asp:Calendar ID="Calendar6" runat="server"></asp:Calendar>
                <asp:Label ID="Label2" runat="server" Text="Total price = "></asp:Label>
                <br />
                <br />
                <br />
                <br />
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Rent" />
                &nbsp;&nbsp;
                <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Show total price" />
            </asp:WizardStep>
            <asp:WizardStep runat="server" title="Show car">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource2">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                        <asp:BoundField DataField="producer" HeaderText="producer" SortExpression="producer" />
                        <asp:BoundField DataField="class" HeaderText="class" SortExpression="class" />
                        <asp:BoundField DataField="model" HeaderText="model" SortExpression="model" />
                        <asp:BoundField DataField="kpp" HeaderText="kpp" SortExpression="kpp" />
                        <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
                        <asp:BoundField DataField="price_per_day" HeaderText="price_per_day" SortExpression="price_per_day" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT car.id, model.producer_id AS producer, model.class, model.model, model.kpp, model.color, model.price_per_day FROM car INNER JOIN model ON car.model_id = model.id INNER JOIN producer ON model.producer_id = producer.name"></asp:SqlDataSource>
                <br />
                <br />
                <br />
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Show my number | Log in">
                Name:&nbsp;
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                &nbsp;&nbsp;
                <br />
                Surname:
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <br />
                Telephone:
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                &nbsp;
                <br />
                Driving license number:
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="Button3" runat="server" Height="41px" OnClick="Button3_Click" Text="Show my number" />
                <br />
                <asp:Label ID="Label3" runat="server" Text="Your number is : "></asp:Label>
                <br />
                <br />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Add | Log in" />
                <br />
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Popular cars">
                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT c.id AS [Car id], COUNT(l.car_id) AS how_much_times FROM car AS c INNER JOIN la AS l ON c.id = l.car_id INNER JOIN model AS m ON c.model_id = m.id WHERE (m.id IN (SELECT TOP (100) PERCENT m1.id FROM model AS m1 INNER JOIN car AS c1 ON m1.id = c1.model_id INNER JOIN la AS l1 ON c1.id = l1.car_id GROUP BY m1.id ORDER BY COUNT(m1.id) DESC)) GROUP BY l.car_id, m.id, c.model_id, c.id ORDER BY how_much_times DESC"></asp:SqlDataSource>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Car id" DataSourceID="SqlDataSource6">
                    <Columns>
                        <asp:BoundField DataField="Car id" HeaderText="Car id" InsertVisible="False" ReadOnly="True" SortExpression="Car id" />
                        <asp:BoundField DataField="how_much_times" HeaderText="how_much_times" ReadOnly="True" SortExpression="how_much_times" />
                    </Columns>
                </asp:GridView>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Available for rent">
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="Car_id" DataSourceID="SqlDataSource7">
                    <Columns>
                        <asp:BoundField DataField="Car_id" HeaderText="Car_id" InsertVisible="False" ReadOnly="True" SortExpression="Car_id" />
                        <asp:BoundField DataField="Producer" HeaderText="Producer" SortExpression="Producer" />
                        <asp:BoundField DataField="model" HeaderText="model" SortExpression="model" />
                        <asp:BoundField DataField="class" HeaderText="class" SortExpression="class" />
                        <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
                        <asp:BoundField DataField="kpp" HeaderText="kpp" SortExpression="kpp" />
                        <asp:BoundField DataField="price_per_day" HeaderText="price_per_day" SortExpression="price_per_day" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT c.id AS Car_id, model.producer_id AS Producer, model.model, model.class, model.color, model.kpp, model.price_per_day FROM car AS c INNER JOIN model ON c.model_id = model.id WHERE (c.id NOT IN (SELECT c1.id FROM car AS c1 INNER JOIN la AS l1 ON c1.id = l1.car_id WHERE ({ fn NOW() } BETWEEN l1.date_start AND l1.date_end)))"></asp:SqlDataSource>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Popular AND available for rent">
                <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:CarrentdbConnectionString1 %>" SelectCommand="SELECT c.id AS [Car id], COUNT(l.car_id) AS how_much_times FROM car AS c INNER JOIN la AS l ON c.id = l.car_id INNER JOIN model AS m ON c.model_id = m.id WHERE (m.id IN (SELECT TOP (100) PERCENT m1.id FROM model AS m1 INNER JOIN car AS c1 ON m1.id = c1.model_id INNER JOIN la AS l1 ON c1.id = l1.car_id GROUP BY m1.id ORDER BY COUNT(m1.id) DESC)) AND (c.id NOT IN (SELECT c1.id FROM car AS c1 INNER JOIN la AS l1 ON c1.id = l1.car_id WHERE ({ fn NOW() } BETWEEN l1.date_start AND l1.date_end))) GROUP BY l.car_id, m.id, c.model_id, c.id ORDER BY how_much_times DESC"></asp:SqlDataSource>
                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="Car id" DataSourceID="SqlDataSource8">
                    <Columns>
                        <asp:BoundField DataField="Car id" HeaderText="Car id" InsertVisible="False" ReadOnly="True" SortExpression="Car id" />
                        <asp:BoundField DataField="how_much_times" HeaderText="how_much_times" ReadOnly="True" SortExpression="how_much_times" />
                    </Columns>
                </asp:GridView>
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>

</asp:Content>

