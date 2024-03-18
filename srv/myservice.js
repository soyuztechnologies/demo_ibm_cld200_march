module.exports = (srv) => {

    srv.on('vendors', (req,res) => {

        var aVendors = [{
            "vendorId": 1,
            "name": "SAP"
        },{
            "vendorId": 2,
            "name": "IBM"
        },{
            "vendorId": 3,
            "name": "Anubhav Trainings"
        },{
            "vendorId": 4,
            "name": "Rob Made changes"
        }];
        console.log("data aaya " + req.data.vendorId);

        for (let i = 0; i < aVendors.length; i++) {
            const element = aVendors[i];
            if(element.vendorId === req.data.vendorId){
                //this is a string data which we return
                return element.name;
            }
        }       


    });

}