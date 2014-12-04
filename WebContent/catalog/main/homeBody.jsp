<%--
 See the NOTICE file distributed with
 this work for additional information regarding copyright ownership.
 Esri Inc. licenses this file to You under the Apache License, Version 2.0
 (the "License"); you may not use this file except in compliance with
 the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
--%>
<% // homeBody.jsp - Home page (JSF body) %>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<f:verbatim>

<script type="text/javascript">
/**
Submits from when on enter.
@param event The event variable
@param form The form to be submitted.
**/
function hpSubmitForm(event, form) {
  var e = event;
  if (!e) e = window.event;
  var tgt = (e.srcElement) ? e.srcElement : e.target; 
  if ((tgt != null) && tgt.id) {
    if (tgt.id == "frmSearchCriteria:mapInput-locate") return;
  }
  
  if(!GptUtils.exists(event)) {
    GptUtils.logl(GptUtils.log.Level.WARNING, 
         "fn submitform: could not get event so as to determine if to submit form ");
    return;
  }
  var code;
  
  if(GptUtils.exists(event.which)) {
    code = event.which;
  } else if (GptUtils.exists(event.keyCode)) {
    code = event.keyCode;
  } else {
    GptUtils.logl(GptUtils.log.Level.WARNING, 
         "fn submitForm: Could not determine key pressed");
    return;
  }
  
  if(code == 13) {
    
    // Getting main search button
    var searchButtonId = "hpFrmSearch:btnDoSearch";
    var searchButton = document.getElementById(searchButtonId);
    if(!GptUtils.exists(searchButton)){
      GptUtils.logl(GptUtils.log.Level.WARNING, 
         "Could not find button id = " + searchButtonId);
    } else if (!GptUtils.exists(searchButton.click)) {
      GptUtils.logl(GptUtils.log.Level.WARNING, 
         "Could not find click action on id = " + searchButtonId);
    } else {
      searchButton.click();
    }
  } else {
    return true;
  }
}

//load recent + top rated
window.onload = function() {
	//parameter count can be used to set number of entries - default=3
	//get JSON (recent)
	var contextPath =  "${pageContext.request.contextPath}";
	var u = contextPath+"/rest/manage/document?list=recent";
	var detailPage= contextPath+"/catalog/search/resource/details.page?uuid=";
	var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", u, false );
    xmlHttp.send( null );
    var jsonO =  JSON.parse(xmlHttp.responseText);
    //show results
    //id,title,user,date,abstract
	var out = "";   
	for(var i = 0; i < jsonO.length; i++) {
		out += "<table  style='width:100%;border:1px solid grey;margin-bottom:1px;height:75px;'>";
        out += "<tr><th colspan='2' rowspan='2' style='text-align: left;vertical-align: top'><a href="+detailPage+jsonO[i].id+">"+jsonO[i].title+"</a></th><td style='text-align: right'><font size='-2'>"+jsonO[i].user+"</font></td><tr><td style='text-align: right'><font size='-2'>"+jsonO[i].date+"</font></td></tr></tr>";
        out += "<tr><td style='text-align: left'><font size='-1'>"+jsonO[i].abstract+"</font></td></tr>";
        out += "</table>";
    }
	dojo.byId("most-recent-results").innerHTML = out;

	//get JSON (top rated)
	var u = contextPath+"/rest/manage/document?list=top";
	var detailPage= contextPath+"/catalog/search/resource/details.page?uuid=";
	var imagePath = contextPath+"/catalog/images/";
	var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", u, false );
    xmlHttp.send( null );
    var jsonO =  JSON.parse(xmlHttp.responseText);
    //show results
    //id,title,user,date,abstract
	var out = "";   
	for(var i = 0; i < jsonO.length; i++) {
		out += "<table  style='width:100%;border:1px solid grey;margin-bottom:1px;height:75px;'>";
        out += "<tr><th colspan='2' rowspan='2' style='text-align: left;vertical-align: top;'><a href="+detailPage+jsonO[i].id+">"+jsonO[i].title+"</a></th><td style='text-align: right'><font size='-2'>"+jsonO[i].user+"    |"+jsonO[i].up+"<img src='"+imagePath+"asn-vote-up.png'  height='14' width='14'>"+jsonO[i].down+"<img src='"+imagePath+"asn-vote-down.png'  height='14' width='14'></font></td><tr><td style='text-align: right'><font size='-2'>"+jsonO[i].date+"</font></td></tr></tr>";
        out += "<tr><td style='text-align: left'><font size='-1'>"+jsonO[i].abstract+"</font></td></tr>";																																	
        out += "</table>";
    }
	dojo.byId("top-rated-results").innerHTML = out;
}
</script>
</f:verbatim>
<f:verbatim>
<p>&nbsp;</p>
</f:verbatim>
<h:outputText escape="false" styleClass="prompt" value="#{gptMsg['catalog.main.home.prompt']}"/>
<h:panelGrid columns="1" summary="#{gptMsg['catalog.general.designOnly']}" width="100%" columnClasses="homeTableLeft" footerClass="homeTableLeftFooter" headerClass="homeTableLeftHeader" cellpadding="0" cellspacing="0">
		<f:facet name="header">
			<h:column>
				<h:graphicImage id="homeTableLeftHeaderImageL" alt="" styleClass="homeTableLeftHeaderImageL" url="/catalog/images/blank.gif" width="15" height="24"></h:graphicImage>
				<h:graphicImage id="homeTableLeftHeaderImageR" alt="" styleClass="homeTableLeftHeaderImageR" url="/catalog/images/blank.gif" width="48" height="24"></h:graphicImage>
				<h:outputText value="#{gptMsg['catalog.main.home.youCanSimply']}"/>
			</h:column>
		</f:facet>
		<h:column>
			<f:verbatim><p>&nbsp;</p></f:verbatim>
			<h:panelGrid columns="1" summary="#{gptMsg['catalog.general.designOnly']}" width="90%" styleClass="homeTableCol">
				<h:panelGrid columns="1" id="_pnlKeyword" cellpadding="0" cellspacing="0" style="margin: 0 auto;">
					<h:outputLabel for="itxFilterKeywordText" value="#{gptMsg['catalog.main.home.topic.findData']}"/>
					<h:form id="hpFrmSearch" onkeypress="javascript: hpSubmitForm(event, this);">
					<h:inputText id="itxFilterKeywordText" 
					  onkeypress="if (event.keyCode == 13) return false;"
					  value="#{SearchFilterKeyword.searchText}" maxlength="400" style="width: 240px" />
					<h:commandButton id="btnDoSearch"
					  value="#{gptMsg['catalog.search.search.btnSearch']}"
					  action="#{SearchController.getNavigationOutcome}"
					  actionListener="#{SearchController.processAction}"
					  onkeypress="if (event.keyCode == 13) return false;">
					  <f:attribute name="#{SearchController.searchEvent.event}"
					    value="#{SearchController.searchEvent.eventExecuteSearch}" />
					</h:commandButton>
					</h:form>
				</h:panelGrid>
			</h:panelGrid>
		</h:column>
		<f:facet name="footer">
			<h:column>
				<h:graphicImage id="homeTableLeftFooterImageL" alt="" styleClass="homeTableLeftFooterImageL" url="/catalog/images/blank.gif" width="23" height="16"></h:graphicImage>
				<h:graphicImage id="homeTableLeftFooterImageR" alt="" styleClass="homeTableLeftFooterImageR" url="/catalog/images/blank.gif" width="21" height="16"></h:graphicImage>
			</h:column>
		</f:facet>
	</h:panelGrid>

<h:panelGrid columns="2" summary="#{gptMsg['catalog.general.designOnly']}" width="100%" columnClasses="homeTableColLeft,homeTableColRight">
	<h:panelGrid columns="1" summary="#{gptMsg['catalog.general.designOnly']}" width="100%"  cellpadding="0" cellspacing="0">
		<h:column>
			   <div>Most Recent Moving Code Packages</div>
			   <div id="most-recent-results"></div>
		</h:column>
	</h:panelGrid>
	<h:panelGrid columns="1" summary="#{gptMsg['catalog.general.designOnly']}" width="100%"  cellpadding="0" cellspacing="0">
		<h:column>
			   <div>Top Rated Moving Code Packages</div>
			   <div id="top-rated-results"></div>
		</h:column>
	</h:panelGrid>        
</h:panelGrid>