

namespace API.DTOs
{
    public class MemberDto
    {
        public int Id{get;set;}
        public string Username{set;get;}
        public string PhotoUrl{set;get;}
        public int Age{set;get;}

        public string KnownAs {get;set;}

        public DateTime  Created {get;set;} 

        public DateTime LastActive {get;set;}  

        public string Gender {set;get;}

        public string Introduction {set;get;}

        public string LookingFor {set;get;}

        public string Interests {set;get;}

        public string City{get;set;}

        public string Country {set; get;}
        
        public ICollection<PhotoDto> Photos {set;get;}
    }
}