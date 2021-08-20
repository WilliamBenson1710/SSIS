#region Help:  Introduction to the script task
/* The Script Task allows you to perform virtually any operation that can be accomplished in
 * a .Net application within the context of an Integration Services control flow. 
 * 
 * Expand the other regions which have "Help" prefixes for examples of specific ways to use
 * Integration Services features within this script task. */
#endregion


#region Namespaces
using System;
using System.Data;
using Microsoft.SqlServer.Dts.Runtime;
using System.Windows.Forms;
using System.Threading;
#endregion

namespace ST_c85c2bb5cb5d4267ae6814774176083d
{
    /// <summary>
    /// ScriptMain is the entry point class of the script.  Do not change the name, attributes,
    /// or parent of this class.
    /// </summary>
	[Microsoft.SqlServer.Dts.Tasks.ScriptTask.SSISScriptTaskEntryPointAttribute]
    public partial class ScriptMain : Microsoft.SqlServer.Dts.Tasks.ScriptTask.VSTARTScriptObjectModelBase
    {
        #region Help:  Using Integration Services variables and parameters in a script
        /* To use a variable in this script, first ensure that the variable has been added to 
         * either the list contained in the ReadOnlyVariables property or the list contained in 
         * the ReadWriteVariables property of this script task, according to whether or not your
         * code needs to write to the variable.  To add the variable, save this script, close this instance of
         * Visual Studio, and update the ReadOnlyVariables and 
         * ReadWriteVariables properties in the Script Transformation Editor window.
         * To use a parameter in this script, follow the same steps. Parameters are always read-only.
         * 
         * Example of reading from a variable:
         *  DateTime startTime = (DateTime) Dts.Variables["System::StartTime"].Value;
         * 
         * Example of writing to a variable:
         *  Dts.Variables["User::myStringVariable"].Value = "new value";
         * 
         * Example of reading from a package parameter:
         *  int batchId = (int) Dts.Variables["$Package::batchId"].Value;
         *  
         * Example of reading from a project parameter:
         *  int batchId = (int) Dts.Variables["$Project::batchId"].Value;
         * 
         * Example of reading from a sensitive project parameter:
         *  int batchId = (int) Dts.Variables["$Project::batchId"].GetSensitiveValue();
         * */

        #endregion

        #region Help:  Firing Integration Services events from a script
        /* This script task can fire events for logging purposes.
         * 
         * Example of firing an error event:
         *  Dts.Events.FireError(18, "Process Values", "Bad value", "", 0);
         * 
         * Example of firing an information event:
         *  Dts.Events.FireInformation(3, "Process Values", "Processing has started", "", 0, ref fireAgain)
         * 
         * Example of firing a warning event:
         *  Dts.Events.FireWarning(14, "Process Values", "No values received for input", "", 0);
         * */
        #endregion

        #region Help:  Using Integration Services connection managers in a script
        /* Some types of connection managers can be used in this script task.  See the topic 
         * "Working with Connection Managers Programatically" for details.
         * 
         * Example of using an ADO.Net connection manager:
         *  object rawConnection = Dts.Connections["Sales DB"].AcquireConnection(Dts.Transaction);
         *  SqlConnection myADONETConnection = (SqlConnection)rawConnection;
         *  //Use the connection in some code here, then release the connection
         *  Dts.Connections["Sales DB"].ReleaseConnection(rawConnection);
         *
         * Example of using a File connection manager
         *  object rawConnection = Dts.Connections["Prices.zip"].AcquireConnection(Dts.Transaction);
         *  string filePath = (string)rawConnection;
         *  //Use the connection in some code here, then release the connection
         *  Dts.Connections["Prices.zip"].ReleaseConnection(rawConnection);
         * */
        #endregion


        /// <summary>
        /// This method is called when this script task executes in the control flow.
        /// Before returning from this method, set the value of Dts.TaskResult to indicate success or failure.
        /// To open Help, press F1.
        /// </summary>
        public void Main()
        {
            // TODO: Add your code here

            //User::SFTPFileName,User::WinSCPLogFileName,$Project::InterfaceWorkingInboundFolder,$Project::SFTPHostKey,$Project::SFTPHostName,$Project::SFTPUserName,$Project::SFTPPassword
            ///ini=nul /command "option batch abort" "option confirm off" "open sftp://cqeldelftp:Sy7BGRcASkuCZ85u@72.32.109.241/ -hostkey=""ssh-rsa 2048 R3G9AvZX+XKBhCZWOKq/CuOdJSr0ES2LCpt7t3En0JM=""" "cd /" "lcd C:\FileTransfer\Branagh\Current" "get facility_export.csv" "exit"

            bool fireAgain = true;

            String SFTPHostName = Dts.Variables["$Project::SFTPHostName"].Value.ToString();
            String SFTPUserName = Dts.Variables["$Project::SFTPUserName"].Value.ToString();
            String SFTPPassword = Dts.Variables["$Project::SFTPPassword"].Value.ToString();
            String SFTPHostKey = Dts.Variables["$Project::SFTPHostKey"].Value.ToString();
            String SFTPFileName = Dts.Variables["User::InboundFileName"].Value.ToString();
            String FolderPathCurrent = Dts.Variables["$Project::InterfaceWorkingInboundFolder"].Value.ToString();
            String SFTPLogFile = Dts.Variables["User::WinSCPLogFileName"].Value.ToString();

            String SFTPCommand = "" + SFTPLogFile + Convert.ToChar(34)
            + " " + "/ini=nul /command " + Convert.ToChar(34) + "option batch abort" + Convert.ToChar(34) ///ini=nul 
            + " " + Convert.ToChar(34) + "option confirm off" + Convert.ToChar(34)
            + " " + Convert.ToChar(34) + "open sftp://" + SFTPUserName + ":" + SFTPPassword + "@" + SFTPHostName + "/" //cqeldelftp:Sy7BGRcASkuCZ85u@72.32.109.241/ 
            + " -hostkey=" + Convert.ToChar(34) + Convert.ToChar(34) + SFTPHostKey + Convert.ToChar(34) + Convert.ToChar(34) + Convert.ToChar(34) // "ssh-rsa 2048 R3G9AvZX+XKBhCZWOKq/CuOdJSr0ES2LCpt7t3En0JM="
            + " " + Convert.ToChar(34) + "cd /" + Convert.ToChar(34)
            + " " + Convert.ToChar(34) + "lcd " + FolderPathCurrent + Convert.ToChar(34)
            + " " + Convert.ToChar(34) + "get " + SFTPFileName + Convert.ToChar(34)
            + " " + Convert.ToChar(34) + "exit" + Convert.ToChar(34);

            String SFTPCommandRemove = "" + SFTPLogFile + Convert.ToChar(34)
            + " " + "/ini=nul /command " + Convert.ToChar(34) + "option batch abort" + Convert.ToChar(34) ///ini=nul 
            + " " + Convert.ToChar(34) + "option confirm off" + Convert.ToChar(34)
            + " " + Convert.ToChar(34) + "open sftp://" + SFTPUserName + ":" + SFTPPassword + "@" + SFTPHostName + "/" //cqeldelftp:Sy7BGRcASkuCZ85u@72.32.109.241/ 
            + " -hostkey=" + Convert.ToChar(34) + Convert.ToChar(34) + SFTPHostKey + Convert.ToChar(34) + Convert.ToChar(34) + Convert.ToChar(34) // "ssh-rsa 2048 R3G9AvZX+XKBhCZWOKq/CuOdJSr0ES2LCpt7t3En0JM="
            + " " + Convert.ToChar(34) + "lcd " + FolderPathCurrent + Convert.ToChar(34)
            + " " + Convert.ToChar(34) + "rm " + SFTPFileName + Convert.ToChar(34)
            + " " + Convert.ToChar(34) + "exit" + Convert.ToChar(34);

            Dts.Variables["User::WinSCPCommand"].Value = SFTPCommand;
            Dts.Variables["User::WinSCPCommandRemoveFile"].Value = SFTPCommandRemove;

            Dts.Events.FireInformation(99, "ScriptCommand", SFTPCommand, "", 0, ref fireAgain);
            Dts.Events.FireInformation(99, "ScriptCommandRemove", SFTPCommandRemove, "", 0, ref fireAgain);
            Dts.Events.FireInformation(99, "WinSCPCommand", Dts.Variables["User::WinSCPCommand"].Value.ToString(), "", 0, ref fireAgain);
            Dts.Events.FireInformation(99, "WinSCPCommandRemoveFile", Dts.Variables["User::WinSCPCommandRemoveFile"].Value.ToString(), "", 0, ref fireAgain);

            Dts.TaskResult = (int)ScriptResults.Success;
        }

        #region ScriptResults declaration
        /// <summary>
        /// This enum provides a convenient shorthand within the scope of this class for setting the
        /// result of the script.
        /// 
        /// This code was generated automatically.
        /// </summary>
        enum ScriptResults
        {
            Success = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Success,
            Failure = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Failure
        };
        #endregion

    }
}
