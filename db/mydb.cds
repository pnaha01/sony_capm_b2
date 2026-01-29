namespace sony.sie;
// include program where we write reusable code in seperate file
using { sony.sie.reuse as reuse } from './myreuse';
// consuming standard reusable aspect from SAP
using {cuid, managed, temporal } from '@sap/cds/common';
// Include structure in ABAP
entity student: reuse.address{
    // consume the reusable type from another file
    key id: reuse.Guid;
    name: String(255);
    age: Int32;
    gender: String(2);
    rollNo: Integer64;
    // Foreign key = name(class)+pk_of_fk(id) = class_id
    class: Association to one class;
}
entity class{
    key id: reuse.Guid;
    specialization: String(255);
    semester: Int16;
    hod: String(255);
    // Cyclic relationship - foreign key
    // Backword Relationship
    //student : Association to many student on student.class = $self;
}

entity book{
    key id: reuse.Guid;
    bookName: localized String(250);
    author: String(250);
}

// using standard aspect
entity Subs : cuid, managed, temporal{
    student: Association to one student;
    book: Association to one book;
}