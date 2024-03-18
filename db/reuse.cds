namespace demo.reuse;

//reusable type to reference data types again and again
type Guid : String(32);

//aspects are like structures which bring the combination of fields for us
aspect address{
    houseNo : Int16;
    street: String(32);
    landmark: String(48);
    city: String(30);
    country: String(2);
}

