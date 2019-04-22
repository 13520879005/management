$(document).ready(function() {
	$('#form1,#form2,#form3,#form4,#form5').validationEngine('attach', {
		promptPosition: 'bottomLeft:-10,-5',
		scroll: false,
		validateNonVisibleFields: false, //是否验证不可见的元素
		autoHidePrompt: true, //是否自动隐藏提示信息
		autoHideDelay: 1000, //自动隐藏提示信息的延迟时间 (ms)
		fadeDuration: 0.3, //隐藏提示信息淡出的时间
		showOneMessage: true, //是否只显示一个提示信息
		maxErrorsPerField: 1
		//单个元素显示错误提示的最大数量，值设为数值。默认 false 表示不限制。
	});
});

