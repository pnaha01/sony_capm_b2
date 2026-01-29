namespace sony.sie.reuse;
// create reuseable type like data element in ABAP
type Guid : String(32) @title : 'Key';

// ABAP we have structure like group of field -- aspects
aspect address{
    houseNo: Int64;
    landmark: String(255);
    city: String(64);
    country: String(2);
    region: String(4);
}
