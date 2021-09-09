            bool fireAgain = true;

            //User::DCYFAccountName,User::DSHSAccountName,User::SQLSelectStringStreetTalk

            String strDCYFAccountName = Dts.Variables["User::DCYFAccountName"].Value.ToString();
            String strDSHSAccountName = Dts.Variables["User::DSHSAccountName"].Value.ToString();
            String strSQLSelectStringStreetTalk = Dts.Variables["User::SQLSelectStringStreetTalk"].Value.ToString();

            Dts.Events.FireInformation(99, "DCYFAccountName:", strDCYFAccountName, "", 0, ref fireAgain);
            Dts.Events.FireInformation(99, "DSHSAccountName", strDSHSAccountName, "", 0, ref fireAgain);
            Dts.Events.FireInformation(99, "SQLSelectStringStreetTalk", strSQLSelectStringStreetTalk, "", 0, ref fireAgain);

            Dts.TaskResult = (int)ScriptResults.Success;
