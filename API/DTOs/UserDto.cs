using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.DTOs
{
    public class UserDto
    {
        public string? Username{set;get;}
        public string? Token{set;get;}
        public string? PhotoUrl { get; set; }

        public string? KnownAs { get; set; }
        public string? Gender {set;get;}
    }
}