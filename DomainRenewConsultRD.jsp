<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/include/PageHeader.jspf" %>
<n:doctype />
<html>
<head>
<title><n:message code="lbl.DOMAIN_EXTEND_REVIEW_CONSULT" text="도메인연장검토품의" escape="html" /></title>
<%@ include file="/WEB-INF/jsp/common/include/HtmlHeader.jspf" %>

<script type="text/javascript">
any.ready(function() {
    fnRetrieve();
    fnDetailList();
});

//조회
function fnRetrieve()
{
    var prx = any.proxy();
    prx.url("/domain.renew.consult.DomainRenewConsultAct/retrieve");
    prx.param("DOMN_RENEW_CONSULT_ID", any.param("DOMN_RENEW_CONSULT_ID"));

    prx.onSuccess = function()
    {
        $('#any_approval').exec("reset");
    };

    prx.onError = function()
    {
        this.error.show();
    };

    prx.execute();
}

// 상세 목록 조회
function fnDetailList()
{
    var prx = $('#gr_mainList').prop("loader").proxy();
    prx.url("/domain.renew.consult.DomainRenewConsultAct/retrieveDetailList");
    prx.param("DOMN_RENEW_CONSULT_ID", any.param("DOMN_RENEW_CONSULT_ID"));

    prx.onSuccess = function()
    {
    };

    prx.onError = function()
    {
        this.error.show();
    };

    prx.execute();
}

//삭제
function fnDelete()
{
    if (!confirm("<n:message code="application.common.msg.confirm.delete" text="정말로 삭제하시겠습니까" escape="js" />")) return;

    var prx = any.proxy();
    prx.url("/domain.renew.consult.DomainRenewConsultAct/delete");
    prx.param("DOMN_RENEW_CONSULT_ID", any.param("DOMN_RENEW_CONSULT_ID"));
    prx.data("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<n:message code="application.common.msg.delete.success" text="삭제되었습니다." escape="js" />");
        any.unloadPage();
    };

    prx.onError = function()
    {
        this.error.show();
    };

    prx.execute();
}

// 수정
function fnModify()
{
    var loc = any.location();
    loc.url("/domain.renew.consult.DomainRenewConsultAct/viewDetail");
    loc.param("DOMN_RENEW_CONSULT_ID", any.param("DOMN_RENEW_CONSULT_ID"));
    loc.param("mode", "U");
    loc.replace();
}

</script>
</head>

<body width="1000" height="600">


<%@ include file="/WEB-INF/jsp/common/include/BodyHeader.jspf" %>
<div class="page-header">
    <h1></h1>
</div>
<table class="view">
    <colgroup>
        <col width="120px">
        <col width="*">
        <col width="120px">
        <col width="*">
    </colgroup>
    <tr>
        <th><n:message code="lbl.CONSULT_SUBJECT" text="품의제목" escape="html" /></th>
        <td colspan="3">
            <div any-text id="CONSULT_SUBJECT" bind="ds_mainInfo" maxByte="2000" readOnly></div>
        </td>
    </tr>
    <tr>
        <th><n:message code="lbl.WRI_PERSON" text="작성자" escape="html" /></th>
        <td>
            <span id="WRI_PERSON_NAME" bind="ds_mainInfo" readOnly></span>
        </td>
        <th><n:message code="lbl.WRI_DATE" text="작성 일자" escape="html" /></th>
        <td>
            <span any-date id="WRI_DATE"  bind="ds_mainInfo"  readOnly></span>
        </td>
    </tr>
</table>

<div class="page-middle">
    <div class="buttons">
        <c:if test="${sessionScope.USER_INFO.sysAdmin}">
            <button any-button onclick="javascript:fnDelete();" name="btn_delete"><n:message code="application.common.btn.delete" text="삭제" escape="html" /></button>
        </c:if>
        <button any-button auto="unload"></button>
    </div>
</div>

<div any-jqgrid id="gr_mainList" fullHeight></div><script ${AI}>
this.addGroupHeader({ start:"INVENTOR_REVIEW_RESULT_NAME" , end:"INVENTOR_REVIEW_RESULT_NAME"       , label:"<n:message code="lbl.EXAM_USER"      text="검토자"     escape="js" />" });
this.addGroupHeader({ start:"PATTEAM_REVIEW_RESULT_NAME"  , end:"PATTEAM_REVIEW_OPIN"               , label:"<n:message code="lbl.JOB_MAN_NAME"   text="법무담당자"     escape="js" />" });
this.addColumn({ width:100, align:"center", sortable:true , name:"REF_NO"                           , label:"<n:message code="lbl.REF_NO_NO"                    text="REF-NO"    escape="js" />" });
this.addColumn({ width:150, align:"center", sortable:true , name:"TITLE"                            , label:"<n:message code="TBL.BIZ_MGT_NAME.000000000000007" text="도메인" escape="js" />" });
this.addColumn({ width:200, align:"center", sortable:true , name:"REG_COMP_NAME"                    , label:"<n:message code="lbl.RIGHT_COMPANY"                text="권리회사" escape="js" />" });
this.addColumn({ width:150, align:"center", sortable:true , name:"DEPT_NAME"                        , label:"<n:message code="lbl.REQ_DEPT_NAME"                    text="의뢰부서"  escape="js" />" });
this.addColumn({ width:100, align:"center", sortable:true , name:"REG_DATE"                         , label:"<n:message code="lbl.REG_DATE"                     text="등록일"    escape="js" />" , formatter:"any-date", fixed:true  });
this.addColumn({ width:80 , align:"center", sortable:true , name:"RIGHT_EXPIR_DATE"                 , label:"<n:message code="lbl.RIGHT_EXPIRE_DATE"            text="권리만료일"      escape="js" />" , formatter:"any-date", fixed:true });
this.addColumn({ width:80 , align:"center", sortable:true , name:"INVENTOR_REVIEW_RESULT_NAME"      , label:"<n:message code="lbl.EXTEND_YN"                    text="연장여부"    escape="js" />" });
this.addColumn({ width:80 , align:"center", sortable:true , name:"PATTEAM_REVIEW_RESULT_NAME"       , label:"<n:message code="lbl.EXTEND_YN"                    text="연장여부"      escape="js" />" });
this.addColumn({ width:80 , align:"left  ", sortable:true , name:"PATTEAM_REVIEW_OPIN"              , label:"<n:message code="lbl.EXAM_REASON"                  text="검토사유"      escape="js" />" });
this.setOption({ rownumbers:true });
this.setButton({ config:true });
// this.addAction("REF_NO", fnMstDetail);
</script>

<div com-approval id="any_approval" apprCode="DMN05" progress-bar="1"></div><script ${AI}>
$(this).on("onReset", function() {
    var ds = any.ds("ds_mainInfo");
    $(this).prop("bizId", any.param("DOMN_RENEW_CONSULT_ID"))
        .prop("reqPerson", ds.value(0, "WRI_PERSON_ID"))
        .prop("reqSubject", ds.value(0, "CONSULT_SUBJECT"))
    ;
});
</script>

<%@ include file="/WEB-INF/jsp/common/include/BodyFooter.jspf" %>

</body>
</html>
