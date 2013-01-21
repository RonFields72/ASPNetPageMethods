<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">

        function addListItem() {
            var friend = {
                firstname: $get("txtfirstname").value,
                lastname: $get("txtlastname").value
            };

            PageMethods.insert_lbxFriends(friend, succeededInsertedCallback, failedInsertedCallback, friend);
        }

        function deleteListItem(sender, e) 
        {
            if (e.keyCode == 46) {
                var friendID = sender.options[sender.selectedIndex].value;
                sender.disabled = true;
                PageMethods.delete_lbxFriends(friendID, succeededDeletedCallback, failedDeletedCallback, sender);
            }
        }

        function succeededDeletedCallback(result, userContext, methodName) 
        {
                userContext.remove(userContext.selectedIndex);
                userContext.disabled = false;
        }
        
        function succeededInsertedCallback(result, userContext, methodName)
        {
                var name = userContext.firstname + " " + userContext.lastname;
                $get("lbxFriends").options.add(new Option(name, result));
        }

        function failedDeletedCallback(error, userContext, methodName) 
        {
            if (error != null) {
                alert(error.get_message());
            }
            userContext.disabled = false;            
        }
        
        function failedInsertedCallback(error, userContext, methodName) 
        {
            if (error != null) {
                alert(error.get_message());
            }
        }        
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager runat="server" ID="smAjax" EnablePageMethods="true">
        </asp:ScriptManager>
        <table>
            <tr>
                <td>
                    Friends
                </td>
                <td>
                    <asp:ListBox runat="server" ID="lbxFriends" onkeydown="deleteListItem(this, event)"
                        DataValueField="friendID" DataTextField="fullname"></asp:ListBox>
                </td>
            </tr>
            <tr>
                <td>
                    Firstname
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtfirstname"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Lastname
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtlastname"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="button" value="Add" onclick="addListItem()" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
