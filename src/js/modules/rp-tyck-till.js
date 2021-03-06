AUI().add('rp-tyck-till',function(A) {
        var Lang = A.Lang,

            DATA_ATTRIBUTE_DIALOG_URL = 'data-dialog-url',
            DIALOG_HEIGHT = 'dialogHeight',
            DIALOG_WIDTH = 'dialogWidth',

            TRIGGER = 'trigger',

            NAME = 'rp-tyck-till',
            NS = 'rp-tyck-till',

            CSS_DIALOG = 'rp-dialog tycktill-dialog',
            CSS_HIDDEN = 'helper-hidden'
            ;

        var TPL_IFRAME = '<div class="iframe-wrap"><iframe src="{iframeSrc}" width="100%" height="100%"></iframe></div>'
            ;

        var TyckTill = A.Component.create(
            {
                ATTRS: {

                    dialogHeight: {
                        value: 670
                    },

                    dialogWidth: {
                        value: 670
                    },

                    trigger: {
                        value: '#tycktillWrap a',
                        setter: A.one
                    }

                },
                EXTENDS: A.Component,
                NAME: NAME,
                NS: NS,

                prototype: {

                    modal: null,

                    initializer: function(config) {
                        var instance = this;

                        instance.messages = {};

                        instance.messages.dialog = {};

                        instance.messages.dialog.title = 'Tyck till';
                        instance.messages.dialog.close = 'Stäng';
                    },

                    renderUI: function() {
                        var instance = this;
                    },

                    bindUI: function() {
                        var instance = this;

                        instance.get(TRIGGER).on('click', instance._onTriggerClick, instance);
                    },

                    _launchDialog: function(dialogURL) {
                        var instance = this;

                        var bodyContent = A.substitute(TPL_IFRAME, {
                            iframeSrc: dialogURL
                        });


                        instance.modal = new A.Modal(
                            {
                                bodyContent: bodyContent,
                                centered: true,
                                cssClass: CSS_DIALOG,
                                headerContent: instance.messages.dialog.title,
                                height: instance.get(DIALOG_HEIGHT),
                                modal: true,
                                zIndex: 1000,
                                width: instance.get(DIALOG_WIDTH),
                                toolbars: {
                                    header: [
                                        {
                                            cssClass: 'close',
                                            label: instance.messages.dialog.close,
                                            on: {
                                                click: function(event) {
                                                    instance.modal.hide();
                                                    event.domEvent.stopPropagation();
                                                }
                                            },
                                            render: true
                                        }
                                    ],

                                    footer: [
                                        {
                                            label: instance.messages.dialog.close,
                                            on: {
                                                click: function(event) {
                                                    instance.modal.hide();
                                                    event.domEvent.stopPropagation();
                                                }
                                            }
                                        }
                                    ]
                                }
                            }
                        ).render();

                        instance.modal.on('render', instance._onDialogRender, instance, instance.modal);

                        instance.modal.after('hide', function(e) {
                            var instance = this;
                            instance.modal.destroy();
                        }, instance, instance.modal);

                    },

                    _onDialogRender: function(e) {
                        var instance = this;
                    },

                    _onTriggerClick: function(e) {
                        var instance = this;

                        e.halt();

                        var linkNode = e.currentTarget;

                        var dialogURL = linkNode.getAttribute(DATA_ATTRIBUTE_DIALOG_URL);

                        instance._launchDialog(dialogURL);
                    },

                    _someFunction: function() {
                        var instance = this;
                    }

                }
            }
        );

        A.TyckTill = TyckTill;

    },1, {
        requires: [
            'aui-base',
            'aui-io',
            'aui-loading-mask',
            'aui-modal',
            'substitute'
        ]
    }
);
