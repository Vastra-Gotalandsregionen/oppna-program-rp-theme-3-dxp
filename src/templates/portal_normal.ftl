<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" dir="<@liferay.language key="lang.dir" />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<@liferay_util["include"] page=top_head_include />

</head>

<body class="${css_class} ${css_rp_admin}">

<#if themeDisplay.getThemeSetting("global-info-header") != "">
	<div class="global-info-header">
		${themeDisplay.getThemeSetting("global-info-header")}
	</div>
</#if>

<a href="#main-content" id="skip-to-content"><@liferay.language key="skip-to-content" /></a>

<@liferay_util["include"] page=body_top_include />

<@liferay.control_menu />

<div class="container-fluid" id="wrapper">

	<header id="banner" role="banner">

		<div id="heading" class="clearfix">
			<h1 class="site-title">
				<a class="${logo_css_class} ${themeDisplay.getThemeSetting('additional-logo-class')}" href="${site_default_url}" title="${site_name}">
					<img alt="${logo_description}" height="${site_logo_height}" src="${site_logo}" width="${site_logo_width}" />
				</a>
			</h1>

			<h2 class="page-title">
				<span>${the_title}</span>
			</h2>


            <#if themeDisplay.getThemeSetting("show-top-navigation-wrap") == "true">
                <div class="top-wrap">
					<div class="top-navigation-wrap">
						<#--<#if is_signed_in>-->
							<#include "${full_templates_path}/top_navigation.ftl" />
						<#--</#if>-->
					</div>
                </div>
			<#else>
                <div class="top-wrap">
					<div class="top-navigation-wrap">
						<nav class="top-navigation clearfix" id="topNavigation">
							<ul class="top-nav-list clearfix">
								<#if is_signed_in>
									<li class="top-nav-user">
										<span>Inloggad som: ${user_name}</span>
									</li>
									<li class="top-nav-signout last">
										<a href="${sign_out_url}">
											<i class="icon-unlock"></i> <span>${sign_out_text}</span>
										</a>
									</li>
								</#if>
							</ul>
						</nav>
					</div>
                </div>

            </#if>
		</div>

		<#if has_navigation || is_signed_in>
			<#include "${full_templates_path}/navigation.ftl" />
		</#if>

	</header>

	<#if selectable>
		<div id="toolsSidebar" class="tools-sidebar">
			<#if show_notifications_portlet>
				<#include "${full_templates_path}/notifications.ftl" />
			</#if>
			<#if is_signed_in && show_tyck_till>
				<#include "${full_templates_path}/tyck_till_content.ftl" />
			</#if>
		</div>
	</#if>

	<div id="content">

		<#if show_breadcrumbs>
			<#include "${full_templates_path}/breadcrumbs.ftl" />
		</#if>

		<#if selectable>
			<@liferay_util["include"] page=content_include />
		<#else>
			${portletDisplay.recycle()}

			${portletDisplay.setTitle(the_title)}

            <@liferay_theme["wrap-portlet"] page="portlet.ftl">
                <@liferay_util["include"] page=content_include />
            </@>
		</#if>

	</div>

</div>

<footer id="footer" role="contentinfo">
	<#include "${full_templates_path}/footer.ftl" />
</footer>

<@liferay_util["include"] page=body_bottom_include />

<#include "${full_templates_path}/theme_js_bottom.ftl" />

<@liferay_util["include"] page=bottom_include />

<script type="text/javascript" src="${javascript_folder}/jq.js"></script>

<#include "${full_templates_path}/piwik.ftl" />

</body>

</html>
