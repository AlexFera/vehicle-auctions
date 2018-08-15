namespace Core.Entities
{
    public class Location
    {
        public string StreetAddress { get; set; }

        public string PostalCode { get; set; }

        public string City { get; set; }

        public string StateOrProvince { get; set; }

        public Country Country { get; set; }
    }
}
