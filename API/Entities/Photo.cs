using System.ComponentModel.DataAnnotations.Schema;


namespace API.Entities
{
    [Table("Photos")]
    public class Photo
    {
        public int Id {get;set;}

        public string? Url {set;get;}

        public bool IsMain { get; set; }
        
        public string? PublicId{set;get;}

        public AppUser AppUser {set;get;}

        public int AppUserId{set;get;}
    }
}