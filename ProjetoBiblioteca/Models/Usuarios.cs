using Microsoft.AspNetCore.Identity;

namespace ProjetoBiblioteca.Models
{
    public class Usuarios
    {
      public  int id {  get; set; }

      public string nome { get; set; } 
      
      public string email {  get; set; }
        
        public string senha_hash { get; set; }

        public string role { get; set; }
        public int ativo { get ; set; }

        public DateTime criando_em { get; set; }
    }
}
