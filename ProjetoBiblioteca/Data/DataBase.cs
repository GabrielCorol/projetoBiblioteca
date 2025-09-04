using MySql.Data.MySqlClient;
//Toda vez que criar uma classe, ele realizará diversas conexões
namespace ProjetoBiblioteca.Data
{
    public class Database
    {
        private readonly string connectionString = "server=localhost;port=3306;database=bdBiblioteca;user=root;password=12345678;";

        public MySqlConnection GetConnection()
        {
            MySqlConnection conn = new MySqlConnection(connectionString);
            conn.Open();
            return conn;
        }


    }
}
