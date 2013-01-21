using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Services;

public partial class _Default : System.Web.UI.Page 
{
    public class friend
    {
        public String firstname { get; set; }
        public String lastname { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            populate_lbxFriends();
        }
    }

    [WebMethod]
    public static void delete_lbxFriends(Int32 friendID)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Default"].ConnectionString))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand("removeFriend", connection))
            {   
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@friendID", friendID);
                command.ExecuteNonQuery();
            }
        }
    }

    [WebMethod]
    public static Object insert_lbxFriends(friend f)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Default"].ConnectionString))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand("addFriend", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@firstname", f.firstname);
                command.Parameters.AddWithValue("@lastname", f.lastname);
                return command.ExecuteScalar();
            }
        }
    }

    protected void populate_lbxFriends()
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Default"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("viewFriends", connection))
            {               
                command.CommandType = CommandType.StoredProcedure;                

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    lbxFriends.DataSource = dt;
                    lbxFriends.DataBind();
                }
            }
        }
    }
}
