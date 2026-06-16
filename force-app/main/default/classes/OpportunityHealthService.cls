public with sharing class OpportunityHealthService {
    public static void calculateHealth(List<Opportunity> opportunities) {
        for (Opportunity opp : opportunities) {
            Integer score = 0;

            if (opp.Amount != null && opp.Amount > 0) {
                score += 25;
            }

            if (opp.SyncedQuoteId != null) {
                score += 25;
            }

            if (!String.isBlank(opp.NextStep)) {
                score += 25;
            }

            if (!String.isBlank(opp.DeliveryInstallationStatus__c)) {
                score += 25;
            }

            opp.Health_Score__c = score;

            if (score >= 90) {
                opp.Health_Status__c = 'Excellent';
            } else if (score >= 70) {
                opp.Health_Status__c = 'Healthy';
            } else if (score >= 40) {
                opp.Health_Status__c = 'Needs Attention';
            } else {
                opp.Health_Status__c = 'At Risk';
            }
        }
    }
}