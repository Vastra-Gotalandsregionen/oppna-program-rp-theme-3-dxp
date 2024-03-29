<#------ Taglibs ----------------------------------------------------------------------------------------------------------------->
<#assign liferay_ui=PortalJspTagLibs["/META-INF/liferay-ui.tld"]>
<#assign aui=PortalJspTagLibs["/META-INF/liferay-aui.tld"]>

<#------ Services ----------------------------------------------------------------------------------------------------------------->
<#assign roleLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.RoleLocalService") />

<#------ Theme CSS class ----------------------------------------------------------------------------------------------------------------->
<#assign css_class = css_class + " dockbar-split" >

<#------ Theme Settings ----------------------------------------------------------------------------------------------------------------->

<#-- Breadcrumbs -->
<#assign show_breadcrumbs = false >

<#if theme_display.getThemeSetting("show-breadcrumbs") == "true">
	<#assign show_breadcrumbs = true />
</#if>

<#if show_breadcrumbs>
	<#assign css_class = css_class + " has-breadcrumbs" >
</#if>

<#-- Use RP Navigation portlet -->
<#assign use_rp_navigation_portlet = false >

<#if theme_display.getThemeSetting("use-rp-nav-portlet") == "true">
	<#assign use_rp_navigation_portlet = true >
</#if>

<#-- Show Notfication bar -->
<#assign show_notifications_bar = false >

<#if theme_display.getThemeSetting("show-notifications-bar") == "true">
	<#assign show_notifications_bar = true />
</#if>

<#-- Show My Sites -->
<#assign show_my_sites = false >

<#if theme_display.getThemeSetting("show-my-sites") == "true">
	<#assign show_my_sites = true />
</#if>

<#-- Show Quick Navigation -->
<#assign show_quick_navigation = true />

<#if theme_display.getThemeSetting("show-quick-navigation") == "false">
	<#assign show_quick_navigation = false />
</#if>

<#assign
sign_out_text = languageUtil.get(locale, "sign-out")
sign_out_url = htmlUtil.escape(theme_display.getURLSignOut())
/>

<#-- Show Tyck till -->
<#assign show_tyck_till = false >

<#if theme_display.getThemeSetting("show-tyck-till") == "true">
	<#assign show_tyck_till = true />
</#if>

<#------ RP Navigation Portlet ----------------------------------------------------------------------------------------------------------------->

<#assign rp_navigation_portlet_id = "aggregatednavigation_WAR_navigationportlet" />

<#------ RP Breadcrumbs Portlet ----------------------------------------------------------------------------------------------------------------->

<#assign use_rp_breadcrumbs_portlet = true />
<#assign rp_breadcrumbs_portlet_id = "aggregatedbreadcrumbs_WAR_navigationportlet" />

<#------ Piwik Tracking Portlet ----------------------------------------------------------------------------------------------------------------->

<#assign piwik_tracking_portlet_id = "piwiktracking_WAR_piwiktrackingportlet" />

<#------ Phrases ----------------------------------------------------------------------------------------------------------------->

<#assign region_portal_name = "Regionportalen" />
<#assign breadcrumbs_label = "Du &auml;r h&auml;r" />

<#------ Top navigation ----------------------------------------------------------------------------------------------------------------->

<#assign topnavSettingsShowText = "Visa meny f&ouml;r inst&auml;llningar" />
<#assign topnavSettingsHideText = "G&ouml;m meny f&ouml;r inst&auml;llningar" />
<#assign topnavQuickAccessText = "Snabbnavigering" />

<#------ Tyck till ----------------------------------------------------------------------------------------------------------------->

<#assign tycktillPortalURL = "#tyck-till" />
<#assign tycktillDialogURL = "//tycktill.vgregion.se/tyck-till/tycktill/KontaktaOss?formName=portalen&breadcrumb=portalen-tycktill" />

<#------ Quick Access Navigation ----------------------------------------------------------------------------------------------------------------->

<#assign quickAccessNavTitle = "Snabbnavigering" />
<#assign quickAccessNavFilterLabel = "Filter" />
<#assign quickAccessNavHelpText = "Skriv in namnet p&aring; det system du letar efter s&aring; sorteras listan efter detta." />

<#------ Notification portlet ----------------------------------------------------------------------------------------------------------------->

<#assign show_notifications_portlet = is_signed_in && show_notifications_bar />

<#assign notifications_portlet_prod_id = "notifications_WAR_notificationsrpportlet" />

<#assign notifications_portlet_id = notifications_portlet_prod_id />

<#------ Login Link Portlet ----------------------------------------------------------------------------------------------------------------->

<#assign loginlink_portlet_id = "loginlink_WAR_navigationportlet" />

<#------ RP Admin ----------------------------------------------------------------------------------------------------------------->

<#assign css_rp_admin = "" />

<#assign is_rp_admin = permissionChecker.isOmniadmin() />

<#if is_rp_admin>
	<#assign css_rp_admin = "rp-admin" />
</#if>

<#------ Regular user ----------------------------------------------------------------------------------------------------------------->
<#assign globalRoles = roleLocalService.getUserRoles(user_id)?size >
<#assign teamRoles = roleLocalService.getUserTeamRoles(user_id, group_id)?size >
<#assign groupRoles = roleLocalService.getUserGroupRoles(user_id, group_id)?size >
<#assign totalNumberOfRoles = globalRoles + teamRoles + groupRoles >

<#if totalNumberOfRoles gt 2 || is_rp_admin>
	<#assign regularUser = false />
<#else>
	<#assign regularUser = true />
</#if>

<#------ Theme Javascript ----------------------------------------------------------------------------------------------------------------->


<#-- If set to true, theme_js_scripts are loaded inline in page (i.e. directly inside a script tag) which reduces the number of http requests -->

<#assign theme_js_inline = false />

<#assign theme_js_scripts = ["fixes/ios-orientationchange-fix.js", "modules/rp-action-confirmation-plugin.js", "modules/rp-asset-publisher.js", "modules/rp-tyck-till.js", "modules/rp-quick-access-nav.js", "modules/rp-system-help.js", "modules/rp-navigation-button.js", "modules/rp-news-carousel.js", "modules/rp-placeholder-plugin.js", "modules/rp-theme-2.js", "theme-main.js"] />

<#------ Portal type ----------------------------------------------------------------------------------------------------------------->

<#assign portalURL = portalUtil.getPortalURL(theme_display) />

<#assign url_server_local = "localhost" />
<#assign url_server_test = "portalen-test" />
<#assign url_server_stage = "portalen-stage" />

<#assign is_server_local = stringUtil.contains(portalURL, url_server_local, "") />
<#assign is_server_test = stringUtil.contains(portalURL, url_server_test, "") />
<#assign is_server_stage = stringUtil.contains(portalURL, url_server_stage, "") />

<#------ Piwik ----------------------------------------------------------------------------------------------------------------->

<#assign piwik_base_url = "piwik.vgregion.se/" />
<#assign protocol_url_prefix = "http://" />
<#if theme_display.isSecure() >
	<#assign protocol_url_prefix = "https://" />
</#if>

<#assign piwik_url = protocol_url_prefix + piwik_base_url />
<#assign piwik_site_id = 77 />

<#------ Macros -------------------------------------------------->

<#-- Include Web Content Display portlet in theme. attribute: group_id is long, article_id is String-->

<#macro includeWCD group_id article_id>
	<#if article_id != "">

		<#local portlet_instance_suffix = "rptheme" />
		<#local instance_id = "wcd" + article_id + portlet_instance_suffix />
		<#local instance_id = instance_id?substring(0, 12) />

		<#assign wcdPortletPreferencesMap = {"articleId": article_id,"groupId": group_id?c,"portletSetupPortletDecoratorId": "barebone"} />

    <@liferay_portlet["runtime"]
        defaultPreferences = freeMarkerPortletPreferences.getPreferences(wcdPortletPreferencesMap)
        instanceId = instance_id
        portletName = "com_liferay_journal_content_web_portlet_JournalContentPortlet"
    />

	<#else>
		&nbsp;
	</#if>
</#macro>

<#macro includePortlet portlet_id>

	<@liferay_portlet["runtime"]
			defaultPreferences = freeMarkerPortletPreferences.getPreferences("portletSetupPortletDecoratorId", "barebone")
			portletName = portlet_id
	/>
</#macro>

<#macro includeInstanceablePortlet portlet_id instance_id>

	<@liferay_portlet["runtime"]
			defaultPreferences = freeMarkerPortletPreferences.getPreferences("portletSetupPortletDecoratorId", "barebone")
			instanceId = instance_id
			portletName = portlet_id
	/>
</#macro>
