
fun calculateTimeStamp() = 
let
	val curtimeint = IntInf.toLarge(time());
	val curtime = SMLTime.fromSeconds(curtimeint);
	val curdate = Date.fromTimeLocal(curtime);
	val timestamp = (Date.fmt "%Y-%m-%dT%H:%M:%S.000" curdate); 
	

in
	timestamp
end;

fun calculateTimeStamp2() = 
let
	val curtimeint = IntInf.toLarge(time());
	val curtime = SMLTime.fromSeconds(curtimeint);
	val curdate = Date.fromTimeLocal(curtime);
	val timestamp = (Date.fmt "%Y-%m-%d" curdate);

in
	timestamp
end;

fun calculateTimeStamp3() = 
let
	val curtimeint = IntInf.toLarge(time())*24*60*60;
	val curtime = SMLTime.fromSeconds(curtimeint);
	val curdate = Date.fromTimeLocal(curtime);
	val timestamp = (Date.fmt "%Y-%m-%dT%H:%M:%S.000" curdate); 
	

in
	timestamp
end;

fun updateDeletionTime(input) = 
let
	
	val furtime = SMLTime.fromSeconds(input);
	val furdate = Date.fromTimeLocal(furtime);
	val furtimestamp = (Date.fmt "%Y-%m-%d" furdate);

in
	furtimestamp
end;



fun calculateDeletionTime(Retention) = 
let
	val furtimeint = (IntInf.toLarge(time())+(Retention*30))*24*60*60;
	val furtime = SMLTime.fromSeconds(furtimeint);
	val furdate = Date.fromTimeLocal(furtime);
	val furtimestamp = (Date.fmt "%Y-%m-%d" furdate);

in
	furtimestamp
end;


fun writeTimeStamp(file_id, timestamp) = 
let
	val _ = TextIO.output(file_id, "<Timestamp>")
	val _ = TextIO.output(file_id, timestamp)


in
	TextIO.output(file_id, "</Timestamp>\n")
end;

fun writeName(file_id, Name) = 
let
	val _ = TextIO.output(file_id, "<Name>")
	val _ = TextIO.output(file_id, Name)


in
	TextIO.output(file_id, "</Name>\n")
end;

fun writeAge(file_id, Age) = 
let
	val _ = TextIO.output(file_id, "<Age>")
	val _ = TextIO.output(file_id, Age)


in
	TextIO.output(file_id, "</Age>\n")
end;

fun writeProfession(file_id, Profession) = 
let
	val _ = TextIO.output(file_id, "<Profession>")
	val _ = TextIO.output(file_id, Profession)


in
	TextIO.output(file_id, "</Profession>\n")
end;

fun writeSalary(file_id, Salary) = 
let
	val _ = TextIO.output(file_id, "<Salary>")
	val _ = TextIO.output(file_id, Salary)


in
	TextIO.output(file_id, "</Salary>\n")
end;

fun writeLicense(file_id, License) = 
let
	val _ = TextIO.output(file_id, "<License>")
	val _ = TextIO.output(file_id, License)


in
	TextIO.output(file_id, "</License>\n")
end;


fun writeWorkflowModelElement(file_id, workflowModelElement) = 
let
	val _ = TextIO.output(file_id, "<WorkflowModelElement>")
	val _ = TextIO.output(file_id, workflowModelElement)


in
	TextIO.output(file_id, "</WorkflowModelElement>\n")
end;


fun getDescription(description) = 
	if length(description) = 0
	then ""
	else hd(description)


fun getComplement(event, description) = 
let
	val desc = getDescription(description)
	val complement = "unknowntype=\"" ^ desc ^ "\""
in
	if event = "unknown"
	then  complement
	else  ""
end;


fun writeEventType(file_id, event :: description) = 
let

	val complement = getComplement(event, description)
	val _ = TextIO.output(file_id, "<EventType ")
	val _ = TextIO.output(file_id, complement)
	val _ = TextIO.output(file_id, ">")		
	val _ = TextIO.output(file_id, event)

in
	TextIO.output(file_id, "</EventType>\n")
end;



fun writeOriginator(file_id, Originator) = 
let
	val _ = TextIO.output(file_id, "<Originator>")
	val _ = TextIO.output(file_id, Originator)

in
	TextIO.output(file_id, "</Originator>\n")
end;


fun writeDataAttributes(nil) = " "
| writeDataAttributes(name::nil) =  "<Attribute name = \"" ^ name ^ "\"> </Attribute>\n" 
| writeDataAttributes(name::value::tail) = "<Attribute name = \"" ^ name ^ "\">" ^value ^" </Attribute>\n" ^ writeDataAttributes(tail) 

fun writeData(file_id, data) = 
let
	val _ = TextIO.output(file_id, "<Data>")
	val _ = TextIO.output(file_id, writeDataAttributes(data))
in
	TextIO.output(file_id, "</Data>")
end;	  

fun  testWriteData (file_id, data) = 
	if length(data) = 0
	then TextIO.output(file_id, "")
	else writeData(file_id, data)

fun add (file_id, workflowModelElement, EventType, TimeStamp, Originator, Data)=
let
	val _ = TextIO.output(file_id, "<AuditTrailEntry>\n")
	val _ = testWriteData(file_id, Data)
	val _ = writeWorkflowModelElement(file_id, workflowModelElement)
	val _ = writeEventType(file_id, EventType)
	val _ = writeTimeStamp(file_id, TimeStamp)
	val _ = writeOriginator(file_id, Originator)
	val _ = TextIO.output(file_id, "</AuditTrailEntry>\n")

in
	TextIO.closeOut(file_id)
end;

fun addATE (caseID,workflowModelElement, EventType, TimeStamp, Originator, Data) = 
let
	val file_id = TextIO.openAppend(FILE^Int.toString(caseID)^FILE_EXTENSION)
in
	add(file_id, workflowModelElement, EventType, TimeStamp, Originator,Data)
end;

fun addATED (caseID,workflowModelElement, EventType, TimeStamp, Originator, Data) = 
let
	val file_id2 = TextIO.openAppend(FILE2^Int.toString(caseID)^FILE_EXTENSION)
in
	add(file_id2, workflowModelElement, EventType, TimeStamp, Originator,Data)
end;



fun writePred_Activity(file_id, Pred_Activity) = 
let
	val _ = TextIO.output(file_id, "<PredActivity>")
	val _ = TextIO.output(file_id, Pred_Activity)

in
	TextIO.output(file_id, "</PredActivity>\n")
end;

fun writeInput(file_id, Input) = 
let
	val _ = TextIO.output(file_id, "<Input>")
	val _ = TextIO.output(file_id, Input)

in
	TextIO.output(file_id, "</Input>\n")
end;

fun writeOutput(file_id, Output) = 
let
	val _ = TextIO.output(file_id, "<Output>")
	val _ = TextIO.output(file_id, Output)

in
	TextIO.output(file_id, "</Output>\n")
end;


fun add2 (file_id, workflowModelElement, EventType, TimeStamp, Pred_Activity, Input, Output, Data)=
let
	val _ = TextIO.output(file_id, "<AuditTrailEntry>\n")
	val _ = testWriteData(file_id, Data)
	val _ = writeWorkflowModelElement(file_id, workflowModelElement)
	val _ = writeEventType(file_id, EventType)
	val _ = writeTimeStamp(file_id, TimeStamp)
	val _ = writePred_Activity(file_id, Pred_Activity)
	val _ = writeInput(file_id, Input)
	val _ = writeOutput(file_id, Output) 
	val _ = TextIO.output(file_id, "</AuditTrailEntry>\n")

in
	TextIO.closeOut(file_id)
end;

fun addATE2 (caseID,workflowModelElement, EventType, TimeStamp, Pred_Activity, Input, Output, Data) = 
let
	val file_id = TextIO.openAppend(FILE^Int.toString(caseID)^FILE_EXTENSION)
in
	add2(file_id, workflowModelElement, EventType, TimeStamp, Pred_Activity, Input, Output, Data)
end;





fun createCaseFile(caseID) = 
let
   val caseIDString = Int.toString(caseID)
   val file_id = TextIO.openOut(FILE ^ caseIDString  ^ FILE_EXTENSION)
   val file_id2 = TextIO.openOut(FILE2 ^ caseIDString  ^ FILE_EXTENSION)
   val _ = TextIO.output(file_id, caseIDString  ^ "\n")
   val _ = TextIO.output(file_id2, caseIDString  ^ "\n")
in
   TextIO.closeOut(file_id);
   TextIO.closeOut(file_id2)
end;


