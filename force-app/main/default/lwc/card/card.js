import { LightningElement, api } from 'lwc';
import getReleatedRecordsByParentId from'@salesforce/apex/SObjectRelatedRecords.getRelatedRecordsByParentId';

export default class Card extends LightningElement {

    errorMsg = '';
    recordList = [];
    @api childObjectApiName;
    @api fieldAPIName;
    @api fieldsString;
    @api recordId;
    defaultMsg = 'Data loading please wait ....';
    isRecordExists;

    connectedCallback() {
        try {
            getReleatedRecordsByParentId({'parentRecordId':this.recordId, 'childObjectApiName':this.childObjectApiName, 'fieldAPIName':this.fieldAPIName, 'fieldsString':this.fieldsString})
            .then(result => {
                if(result.status == 'success') {
                    this.parseData(JSON.parse(JSON.parse(JSON.stringify(result.data))));
                    this.isRecordExists = true;
                } else {
                    this.defaultMsg = 'No records to display';
                    this.isRecordExists = false;
                }
            })
            .catch(error => {
                this.error = error;
            }); 
        } catch(error) {
            console.log(error);
        }
    }


    parseData(result) {
        let record = [];
        let field = {};
        let fieldList = [];
        let relatedRecordList = [];
        for(let i=0; i<result.length; i++) {
            fieldList = [];
            record = [];
            let fields = this.fieldsString.split(',');
            for(let j=0; j<fields.length; j++) {
                if(result[i][fields[j].trim()] != '') {
                    field = {};
                    field.apiName = fields[j];
                    field.value = result[i][fields[j].trim()];
                    fieldList.push(field);
                }
            }
            record['Id'] = result[i].Id;
            record['fields'] = [...fieldList];
            relatedRecordList.push(record);
        }
        this.recordList = [...relatedRecordList];
    }
}