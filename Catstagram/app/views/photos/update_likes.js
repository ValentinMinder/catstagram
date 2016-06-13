$("#like").removeClass("btn-success");
$("#like").addClass("btn-info");

// si je decommente cette ligne, je peux """disable""" le bouton
// mais en pratique ça fait juste qu'il fait de la merde avec le js
// si on clique dessus :/

// $("#like").attr("disabled", "disabled");

$("#like_count").text("<%= @photo.like_count %>");
