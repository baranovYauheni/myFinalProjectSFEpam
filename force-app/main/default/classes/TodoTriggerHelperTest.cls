@IsTest
private class TodoTriggerHelperTest {
    @IsTest
    static void testPushInserted() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TodoResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());
        List<ToDo__c> todos = new List<ToDo__c>();
        Test.startTest();
        TodoTriggerHelper.pushInsert(todos);
        Integer futureCalls = Limits.getFutureCalls();
        Test.stopTest();
        System.assertEquals(1, futureCalls);
    }

    @IsTest
    static void testpushUpdated() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TodoResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());
        List<ToDo__c> todos = new List<ToDo__c>();
        Test.startTest();
        TodoTriggerHelper.pushUpdated(todos);
        Integer futureCalls = Limits.getFutureCalls();
        Test.stopTest();
        System.assertEquals(1, futureCalls);
    }

    @IsTest
    static void testpushDeleted() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TodoResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());
        List<ToDo__c> todos = new List<ToDo__c>();
        Test.startTest();
        TodoTriggerHelper.pushDeleted(todos);
        Integer futureCalls = Limits.getFutureCalls();
        Test.stopTest();
        System.assertEquals(1, futureCalls);
    }
}