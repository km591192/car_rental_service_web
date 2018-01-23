<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Security" %>

<script runat="server">
    void Logon_Click(object sender, EventArgs e)
    {
        if ((ALogin.Text == "admin") && (UserPass.Text == "admin"))
        {
            {
                FormsAuthentication.RedirectFromLoginPage(ALogin.Text, Persist.Checked);
                Response.Redirect("AdminHome.aspx");
            }
        }
        else
        {
            Msg.Text = "Invalid credentials. Please try again.";
        }
    }
    
</script>
<html>
<head id="Head1" runat="server">
  <title>Forms Authentication - Login</title>
    <style type="text/css">
        .auto-style1 {
            font-size: medium;
            text-align: center;
        }
        #form1 {
            text-align: center;
        }
        .auto-style2 {
            font-size: medium;
            text-align: center;
        }
    </style>
</head>
<body>
  <form id="form1" runat="server">
    <h3 class="auto-style2">
      Log in</h3>
    <table align="center" >
      <tr>
        <td class="auto-style1">
          Admin login:</td>
        <td>
          <asp:TextBox ID="ALogin" runat="server" CssClass="auto-style1" /></td>
        <td>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
            ControlToValidate="ALogin"
            Display="Dynamic" 
            ErrorMessage="Cannot be empty." 
            runat="server" CssClass="auto-style1" />
        </td>
      </tr>
      <tr>
        <td class="auto-style1">
          Password:</td>
        <td>
          <asp:TextBox ID="UserPass" TextMode="Password" 
             runat="server" CssClass="auto-style1" />
        </td>
        <td>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" 
            ControlToValidate="UserPass"
            ErrorMessage="Cannot be empty." 
            runat="server" CssClass="auto-style1" />
        </td>
      </tr>
        <tr>
        <td class="auto-style1">
          Remember me?</td>
        <td>
          <asp:CheckBox ID="Persist" runat="server" CssClass="auto-style1" /></td>
      </tr>
    </table>
    <asp:Button ID="Submit1" OnClick="Logon_Click" Text="Log In" 
       runat="server" CssClass="auto-style1" />
    &nbsp;<p>
      <asp:Label ID="Msg" ForeColor="red" runat="server" CssClass="auto-style1" />
    </p>
      <p>
          &nbsp;</p>
      <p>
          &nbsp;</p>
  </form>
</body>
</html>