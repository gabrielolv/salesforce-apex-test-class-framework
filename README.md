# Salesforce Apex Test Class Framework

# Data Factory Architecture

Composable Data Factories are simple, easy to read, and flexible to reuse. You will learn more by walking through MDF_FactoryOrchestrator.cls but the basic architecture looks like this,

![alt text](<Data Factory.jpg>)

Each Object Factory can be reused in different feature sets to create a configurable and abstracted record that fits the needs of the specific tests.
A basic insert of a configured object could be written like this:
```
this.account = MDF_AccountFactory.start()
                .withRecordType(recordTypeDeveloperName)
                .withAccountSource(source)
                .withBillingAddress()
                .create();
```
And the simple logic inside these composable functions might look like this:
```
public MDF_AccountFactory withBillingAddress() {
    current.BillingStreet = '1355 West 3100 South';
    current.BillingCity = 'West Valley City';
    current.BillingState = 'UT';
    current.BillingPostalCode = '84119';
    current.BillingCountry = 'United States';
    return this;
}
```
And the Orchestrator can be used to create a set of objects like this:
```
MDF_FactoryOrchestrator.TestData testData = MDF_FactoryOrchestrator.start()
            .withAccount('Business_Account','Partner Referral')
            .withProduct()
            .withPricebookEntry()
            .withOpportunity('Opp_Record_Type')
            .withOpportunityLineItem()
            .build();
```
