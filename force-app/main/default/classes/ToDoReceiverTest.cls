@isTest
private class ToDoReceiverTest {

    static ToDo__c createRecord() {
        ToDo__c testTodo = new ToDo__c(Name = 'Test01',
                                       Category__c = 'Later',
                                       Status__c = 'In Progress',
                                       ExternalId__c = 'a010900000nVG0NAAW');
        insert testTodo;
        return testTodo;
    }
    
    static ToDo__c createRecord2() {
        ToDo__c testTodo = new ToDo__c(Name = 'Test02',
                                       Category__c = 'Later',
                                       Status__c = 'In Progress',
                                       ExternalId__c = null);
        insert testTodo;
        return testTodo;
    }


    @IsTest
    static void testCreateTodo() {
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf(
            '[ { "category" : "Later", "name" : "Test01", "id" : "a010900000nVG0NAAW", "rectypeName" : "Later", "status":"In Progress" } ]'
            );
        RestContext.request = request;
        List<Id> ids = ToDoReceiver.createTodo();
        System.assert(ids != null);
        List<ToDo__c> todos = [SELECT Name FROM ToDo__c WHERE Id IN :ids];
        System.assert(todos.size() == 1);
        System.assertEquals(todos.get(0).Name, 'Test01');
    }

    @IsTest
    static void testUpdateTodo() {
        ToDo__c todo = createRecord();
        System.assert(todo != null);
        System.assertEquals(todo.Name, 'Test01');
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf(
            '[{"name": "Test001", "rectypeName" : "Later", "category" : "Later",  "status":"In Progress", "id":"' + todo.ExternalId__c + '"}]'
        );
        RestContext.request = request;
        List<Id> ids = ToDoReceiver.updateTodo();
        System.assert(ids != null);
        ToDo__c updatedTodo = [SELECT Id, Name FROM ToDo__c WHERE Id = :todo.Id];
        System.debug('updatedTodo: ' + updatedTodo);
        System.assert(updatedTodo != null);
        System.assertEquals(updatedTodo.Name, 'Test001');
        
        todo = createRecord2();
        System.assert(todo != null);
        System.assertEquals(todo.Name, 'Test02');
        request = new RestRequest();
        request.requestBody = Blob.valueOf(
            '[{"name": "Test002", "rectypeName" : "Later", "category" : "Later", "status" : "In Progress", "id":"' + todo.Id + '"}]'
        );
        RestContext.request = request;
        ids = ToDoReceiver.updateTodo();
        System.assert(ids != null);
        updatedTodo = [SELECT Id, Name FROM ToDo__c WHERE Id = :todo.Id];
        System.debug('updatedTodo 2: ' + updatedTodo);
        System.assert(updatedTodo != null);
        System.assertEquals(updatedTodo.Name, 'Test002');
    }

    @IsTest
    static void testDeleteTodo() {
        ToDo__c todo = createRecord();
        System.assert(todo != null);
        System.assertEquals(todo.Name, 'Test01');
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('[{"name": "Test01", "rectypeName" : "Later", "status":"In Progress", "id":"' + todo.ExternalId__c + '"}]');
        RestContext.request = request;
        List<ToDo__c> todos = [SELECT Id FROM ToDo__c];
        System.assert(todos.size() == 1);
        List<Id> deletedIds = ToDoReceiver.deleteTodo();
        System.assert(deletedIds != null);
        List<ToDo__c> deletedTodos = [SELECT Id FROM ToDo__c];
        System.assert(deletedTodos.size() == 0);
    }
}