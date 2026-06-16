@IsTest
private class OpportunityHealthServiceTest {

    @IsTest
    static void calculatesHealthyHealthWhenMostCriteriaAreMet() {
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Qualification',
            CloseDate = Date.today().addDays(30),
            Amount = 25000,
            NextStep = 'Follow up with customer',
            DeliveryInstallationStatus__c = 'In progress'
        );

        OpportunityHealthService.calculateHealth(
            new List<Opportunity>{ opp }
        );

        System.assertEquals(75, opp.Health_Score__c);
        System.assertEquals('Healthy', opp.Health_Status__c);
    }

    @IsTest
    static void calculatesAtRiskHealthWhenCriteriaAreMissing() {
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity - At Risk',
            StageName = 'Qualification',
            CloseDate = Date.today().addDays(30)
        );

        OpportunityHealthService.calculateHealth(
            new List<Opportunity>{ opp }
        );

        System.assertEquals(0, opp.Health_Score__c);
        System.assertEquals('At Risk', opp.Health_Status__c);
    }

    static void triggerPopulatesHealthFieldsOnInsert()
}