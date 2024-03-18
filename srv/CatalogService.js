module.exports = cds.service.impl( async function(){

    const { EmployeeSet,POs } = this.entities;

    //before an UPDATE operation on EmployeeSet
    this.before("UPDATE", EmployeeSet, async (req, res) => {
        if(req.data.salaryAmount > 1000000){
            req.error(500, "the salary over million is not allowed");
        }
    });

    this.on('boost', async (req,res) => {

        //Step1 : receive the key of the order as a parameter
        var ID = req.params[0];
        console.log("ID : ", ID);
        //Step2: Start a transaction using CDS QL
        const tx = cds.tx(req);
        //Step3: Communicate to DB
        await tx.update(POs).with({
            GROSS_AMOUNT: { '+=' : 20000 }
        }).where(ID);

    });

    this.on('largestOrder', async (req,res) => {
        try {

            const tx = cds.tx(req);
            //SELECT * UPTO 1 ROW FROM dbtab ORDER BY GROSS_AMOUNT desc
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);

            return reply;
        } catch (error) {
            return "Error " + error.toString();
        }
    });

});