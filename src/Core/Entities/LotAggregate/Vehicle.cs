using System;

namespace Core.Entities.LotAggregate
{
    public class Vehicle
    {
        public string Make { get; set; }

        public string Model { get; set; }

        public string VIN { get; set; }

        public string Color { get; set; }

        public int Mileage { get; set; }

        public string ImageUrl { get; set; }

        public DateTime FirstRegistrationDate { get; set; }

        public double EngineCapacity { get; set; }

        public string EngineType { get; set; }

        public short NumberOfDoors { get; set; }

        public string FuelType { get; set; }

        public string EquipmentInterior { get; set; }

        public string EquipmentExterior { get; set; }

        public string EquipmentInfotainment { get; set; }

        public string EquipmentEngineTechnology { get; set; }

        public string VehicleSource { get; set; }

        public string CurrentCountryOfRegistration { get; set; }

        public bool HasServiceHistory { get; set; }

        public short EuroEmissionStandard { get; set; }

        public bool HasAccidentDamage { get; set; }

        public bool HasSecondKeyAvailable { get; set; }

        public string TransmissionType { get; set; }

        public string EnginePower { get; set; }
    }
}
