/*
   This file is part of MusicBrainz, the open internet music database.
   Copyright (C) 2010 MetaBrainz Foundation

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

*/

MB.Control.GuessCase = function (type, $name) {
    var self = {};

    self.type = type;
    self.$name = $name;

    self.guesscase = function () {
        self.$name.val (MB.GuessCase[self.type].guess (self.$name.val ()));
    };

    ko.applyBindingsToNode($("div.guess-case.bubble")[0],
        { guessCase: self.guesscase });

    return self;
};


MB.Control.SortName = function (type, $name, $sortname, $cont) {
    var self = {};

    self.type = type;
    self.$name = $name;
    self.$sortname = $sortname;

    self.$sortname_button = $cont.find('a[href=#sortname]');
    self.$copy_button = $cont.find('a[href=#copy]');

    self.sortname = function (event) {
        self.$sortname.val (MB.GuessCase[self.type].sortname (self.$name.val ()));

        event.preventDefault ();
    };

    self.copy = function (event) {
        self.$sortname.val (self.$name.val ());

        event.preventDefault ();
    };

    self.initialize = function () {
        self.$sortname_button.bind ('click.mb', self.sortname);
        self.$copy_button.bind ('click.mb', self.copy);
    };

    return self;
};

MB.Control.ArtistSortName = function (type, $name, $sortname) {
    var self = MB.Control.SortName (type, $name, $sortname, $('body'));

    self.$type   = $('#id-edit-artist\\.type_id');

    self.sortname = function (event) {
        var person = self.$type.val () !== '2';

        self.$sortname.val (MB.GuessCase.artist.sortname (self.$name.val (), person));

        event.preventDefault ();
    };

    return self;
};


/* A generic guess case initialize function for use outside the
   release editor. */
MB.Control.initialize_guess_case = function (bubbles, type, form_prefix) {

    var $name = $('input#' + form_prefix + '\\.name');
    var $gcdoc = $('div.guess-case.bubble');

    bubbles.add ($name, $gcdoc);
    MB.Control.GuessCase (type, $name);

    if (type === 'label' || type === 'artist' || type === 'area' || type === 'place')
    {
        var $sortname = $('input#' + form_prefix + '\\.sort_name');
        var $sortdoc = $('div.sortname.bubble');

        bubbles.add ($sortname, $sortdoc);
        if (type === 'artist')
        {
            MB.Control.ArtistSortName (type, $name, $sortname).initialize ();
        }
        else
        {
            MB.Control.SortName (type, $name, $sortname, $('body')).initialize ();
        }
    }
};


ko.bindingHandlers.guessCase = {

    init: function (element, valueAccessor, allBindingsAccessor,
                    viewModel, bindingContext) {

        var gc = MB.GuessCase.Main();
        var callback = valueAccessor();
        var cookieSettings = { path: "/", expires: 365 };

        var bindings = {
            modeName: ko.observable(gc.modeName),
            keepUpperCase: ko.observable(gc.CFG_UC_UPPERCASED),
            upperCaseRoman: ko.observable(gc.CFG_UC_ROMANNUMERALS),
            guessCase: _.bind(callback, bindings)
        };

        var mode = ko.computed(function () {
            var modeName = bindings.modeName()

            if (modeName !== gc.modeName) {
                gc.modeName = modeName;
                gc.mode = MB.GuessCase.Mode[modeName]();
                $.cookie("guesscase_mode", modeName, cookieSettings);
            }
            return gc.mode;
        });

        bindings.help = ko.computed(function () {
            return mode().getDescription();
        });

        bindings.keepUpperCase.subscribe(function (value) {
            gc.CFG_UC_UPPERCASED = value;

            $.cookie("guesscase_keepuppercase", value, cookieSettings);
        });

        bindings.upperCaseRoman.subscribe(function (value) {
            gc.CFG_UC_ROMANNUMERALS = value;

            $.cookie("guesscase_roman", value, cookieSettings);
        });

        var context = bindingContext.createChildContext(bindings);
        ko.applyBindingsToDescendants(context, element);

        return { controlsDescendantBindings: true };
    }
};
