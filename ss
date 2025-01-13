 boolean isDependant;
               @Parameters({"browser","browserversion","os"})
               @BeforeMethod(alwaysRun=true)
               public void beforMethod(@Optional("chrome") String browser, @Optional("90.0") String browserversion, @Optional("Windows 10") String os, Method method) throws Throwable   {
            	 
            	  currentBrowser = browser;
            	   System.out.println("Execution of before method started");
            	   currentTestName = method.getName();
                   System.out.println("<*****>Started Execution of script "+currentTestName+"<*****>");
               
                              isDependant = false;
                              try {                       
                                             Test testClass = method.getAnnotation(Test.class);
                                             if(testClass.dependsOnMethods().length>0) {
                                                            isDependant = true;
                                             }
                         
                        testExecutionPlatform=ExecutionPlatform;

                                           //  currentTestName = method.getName();
                                           //  System.out.println("<*****>Started Execution of script "+currentTestName+"<*****>");
                                             startTestForReport(browser, browserversion, os, method.getName() );
                                           
                                            		   this.createDriver(browser,browserversion, os, method.getName(), deviceName);
                                         			 
                                            	   }
                                            	 
                              catch(Exception e)
                              {
                                             Reporter.insertReportLine(e);
                              } 
               
               
               }
