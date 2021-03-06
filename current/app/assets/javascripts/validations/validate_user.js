$(document).ready(function() {
  // Replace form button with loader.
  // $("#billing-button-button").click(function() {
  //   $("#billing-button").hide();
  //   $("#billing-loader").show();
  //   $("#billing-loader .loading").show();
  // });
  // $("#shipping-button-button").click(function() {
  //   $("#shipping-button").hide();
  //   $("#shipping-loader").show();
  //   $("#shipping-loader .loading").show();
  // });

  // If javascript is enabled, hide the shipping details by default.
  $("#shipping-details").hide();
  //$("#billing-button").show();

  // Fix select buttons so they can be customized with CSS
  $("select").select_skin();

  // Fix checkboxes so they can be customized with CSS
  $("input[type='checkbox']").each(function() {
    $(this).wrap(function() {
      if ($(this).is(":checked")) {         
        return "<div class='custom-checkbox-container selected' />";
      } else {        
        return "<div class='custom-checkbox-container' />";
      }
    });
    $(this).wrap("<div class='custom-checkbox-hitarea'>");
    $(this).parent().append("<div class='custom-checkbox-checkmark'></div>");
  });

  $("#user_billing_same_as_shipping").each(function() {
    if ($(this).is(":checked") || $(this).attr("checked") == "checked" || $(this).attr("checked") == true) {
      $("#shipping-details").hide();
    } else {
      $("#shipping-details").show();
    }
  })
  
  // Toggle the actual checkbox on and off so it submits with the form
  $("#user_billing_same_as_shipping").click(function () { // NOTE: This is tied directly to the ID generated by the checkout user form.
    $(this).parent().parent().toggleClass("selected");
    if ($(this).attr("checked") == "checked" || $(this).attr("checked") == true) {
      // Turn shipping details OFF
      $("#shipping-details").slideToggle("fast");
      //removeRules(shipping_rules);
      //removeMessages(shipping_messages);
      //addRules(billing_rules);
      //addMessages(billing_messages);
    } else {
      // Turn shipping details ON
      $("#shipping-details").slideToggle("fast");
      //removeRules(billing_rules);
      //removeMessages(billing_messages);
      //addRules(shipping_rules);
      //addMessages(shipping_messages);
    }
  });

  $("#user_include_in_mailinglist").click(function() { // Generic on/off for custom checkbox.
    $(this).parent().parent().toggleClass("selected");
  });

  var billing_rules = {
    "user[username]": {
      required: true,
      minlength: 2
    },
    // "user[password]": {
    //   required: true,
    //   minlength: 5
    // },
    // "user[password_confirmation]": {
    //   required: true,
    //   minlength: 5
    // },
    // "user[full_name]": {
    //   required: true,
    //   minlength: 2
    // },
    "user[email]": {
      required: true,
      email: true
    }//,
    // "user[address]": {
    //   required: true,
    //   minlength: 2
    // },
    // "user[city]": {
    //   required: true,
    //   minlength: 2
    // },
    // "user[country]": {
    //   required: true
    // },
    // "user[postal]": {
    //   required: true
    // },
    // "user[phone]": {
    //   required: true
    // },
    // "user[shipping_address]": {
    //   required: false
    // },
    // "user[shipping_city]": {
    //   required: false
    // },
    // "user[shipping_province]": {
    //   required: false
    // },
    // "user[shipping_country]": {
    //   required: false
    // },
    // "user[shipping_postal]": {
    //   required: false
    // },
    // "user[shipping_phone]": {
    //   required: false
    // }
  };

  var billing_messages = {
  };

  // var shipping_rules = {
  //   "user[name]": {
  //     required: true,
  //     minlength: 2
  //   },
  //   "user[email]": {
  //     required: true,
  //     email: true
  //   },
  //   "user[address]": {
  //     required: true,
  //     minlength: 2
  //   },
  //   "user[city]": {
  //     required: true,
  //     minlength: 2
  //   },
  //   "user[country]": {
  //     required: true
  //   },
  //   "user[postal]": {
  //     required: true
  //   },
  //   "user[phone]": {
  //     required: true
  //   },
  //   "user[shipping_address]": {
  //     required: true
  //   },
  //   "user[shipping_city]": {
  //     required: true
  //   },
  //   "user[shipping_province]": {
  //     required: true
  //   },
  //   "user[shipping_country]": {
  //     required: true
  //   },
  //   "user[shipping_postal]": {
  //     required: true
  //   },
  //   "user[shipping_phone]": {
  //     required: true
  //   }
  // };

  var shipping_messages = {
  }

  // Validate the form
  var validator = $("#register-form").validate({
    rules: billing_rules,
    messages: billing_messages,
    errorPlacement: function(error, element) {
      if (element.is(":radio"))
        error.appendTo(element.parent().next().next());
      else if (element.is(":checkbox"))
        error.appendTo(element.next());
      else if (element.is("select") && element.parent().hasClass("custom-select-container"))
        error.appendTo(element.parent().parent().next());
      else
        error.appendTo(element.parent().next());
    },
    highlight: function(element, errorClass, validClass) {
      var container;
      if ($(element).is("select"))
        container = $(element).parent().parent().parent();
      else
        container = $(element).parent().parent();
      if (container.hasClass("field-is-valid"))
        container.removeClass("field-is-valid");
      container.addClass("field-with-errors");
    },
    unhighlight: function(element, errorClass, validClass) {
      var container;
      if ($(element).is("select"))
        container = $(element).parent().parent().parent();
      else
        container = $(element).parent().parent();
      if (container.hasClass("field-with-errors"))
        container.removeClass("field-with-errors");
      container.addClass("field-is-valid");
    },
    // Take over the form submission process so the user doesn't get an extra, unneeded step before going to PayPal.
    // submitHandler: function(form) {
    //   $.ajax({
    //     url: "",
    //     context: document.body
    //   });
    //   return false;
    // }
  });

  // Helper functions
  function addRules(rulesObj) {
    for (item in rulesObj) {
      $("[name='" + item + "']").rules("add", rulesObj[item]);
    }
  }

  function addMessages(messagesObj) {
    for (item in messagesObj) {
      $("[name='" + item + "']").messages("add", messagesObj[item]);
    }
  }

  function removeRules(rulesObj) {
    for (item in rulesObj) {
      $("[name='" + item + "']").rules("remove");
    }
  }

  function removeMessages(messagesObj) {
    for (item in messagesObj) {
      $("[name='" + item + "']").messages("remove");
    }
  }

});
