@Parameters({"browser", "browserversion", "os"})
@BeforeMethod(alwaysRun = true)
public void beforeMethod(@Optional("chrome") String browser, 
                        @Optional("90.0") String browserversion, 
                        @Optional("Windows 10") String os, 
                        Method method) throws Throwable {
    
    currentBrowser = browser;
    logger.info("Execution of before method started");
    currentTestName = method.getName();
    logger.info("<*****>Started Execution of script " + currentTestName + "<*****>");
    
    isDependant = false;
    
    try {
        // Check for test dependencies
        Test testClass = method.getAnnotation(Test.class);
        if (testClass != null && testClass.dependsOnMethods().length > 0) {
            isDependant = true;
            logger.debug("Test has dependencies: {}", 
                String.join(", ", testClass.dependsOnMethods()));
        }
        
        // Set execution platform
        testExecutionPlatform = ExecutionPlatform;
        
        // Initialize test reporting
        startTestForReport(browser, browserversion, os, method.getName());
        
        // Create WebDriver instance
        this.createDriver(browser, browserversion, os, method.getName(), deviceName);
        
    } catch (Exception e) {
        logger.error("Error in beforeMethod execution", e);
        Reporter.insertReportLine(e);
        throw e; // Re-throw to ensure test failure
    }
}
