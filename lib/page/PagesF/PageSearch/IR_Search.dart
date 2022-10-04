import 'dart:math';

class Ir {
  savename(var listdict) {
    var listname = [];
    for (var i in listdict) {
      listname.add(i["name"]);
    }
    return listname;
  }

  countworddoctf(var listdict) {
    var listj = [];
    var listn = [];

    for (var i in listdict) {
      for (var j in i["sentences"]) {
        if (listj.length == 0) {
          var word = {};
          word["word"] = j;
          listn.add(j);

          for (int k = 0; k < listdict.length; k++) {
            int c = 0;
            for (var l = 0; l < listdict[k]["sentences"].length; l++) {
              //print("ปริ้น");
              if (j == listdict[k]["sentences"][l]) {
                c = c + 1;
              }
            }
            word[listdict[k]["name"]] = c;
          }
          listj.add(word);
        } else {
          if (listn.indexOf(j) < 0) {
            var word = {};
            word["word"] = j;
            listn.add(j);
            for (int k = 0; k < listdict.length; k++) {
              var c = 0;
              for (int l = 0; l < listdict[k]["sentences"].length; l++) {
                if (j == listdict[k]["sentences"][l]) {
                  c = c + 1;
                }
              }
              word[listdict[k]["name"]] = c;
            }
            listj.add(word);
          }
        }
      }
    }
    return listj;
  }

  t_max0(var listword_tf, var name) {
    var listt_max = {};
    for (var i in listword_tf) {
      int max = -100;
      for (int j = 0; j < name.length; j++) {
        if (i[name[j]] > max) {
          max = i[name[j]];
        }
      }
      listt_max[i["word"]] = max;
    }
    return listt_max;
  }

  t_max(var listword_tf, var name) {
    var listt_max = {};
    for (var i in listword_tf) {
      for (var j = 0; j < name.length; j++) {
        if (listt_max.containsKey(name[j]) == false) {
          listt_max[name[j]] = -100;
        }
        if (listt_max.containsKey(name[j])) {
          if (i[name[j]] > listt_max[name[j]]) {
            listt_max[name[j]] = i[name[j]];
          }
        }
      }
    }
    return listt_max;
  }
}

normalise_tf(var listword_tf, var t_maxx, var name) {
  var listnor = [];
  for (var i in listword_tf) {
    var nor = {};
    nor["word"] = i["word"];
    for (int j = 0; j < name.length; j++) {
      nor[name[j]] = i[name[j]] / t_maxx[name[j]];
    }
    listnor.add(nor);
  }
  return listnor;
}

countdf(var listword_tf, var name) {
  var listdf = {};
  for (var i in listword_tf) {
    int c = 0;
    for (int j = 0; j < name.length; j++) {
      if (i[name[j]] > 0) {
        c = c + 1;
      }
    }
    listdf[i["word"]] = c;
  }
  return listdf;
}

invert_idf(var countdfx, var name, var savewordx) {
  var lengthname = name.length;
  var listidf = {};
  for (var i in savewordx) {
    listidf[i] = log(lengthname / countdfx[i]);
  }
  return listidf;
}

saveword(var countdfx) {
  var listword = [];
  for (var i in countdfx.keys) {
    listword.add(i);
  }
  //print("%%%%%%%%%%%%%%%%");
  return listword;
}

weigth(var tf, var idf, var name, var save) {
  var listweight = [];
  for (var i in idf.keys) {
    //print(i);
    //print(idf[i]);
    var w = {};
    w["word"] = i;
    for (var j in name) {
      //print("IIIII JJJJJJ");
      //print(j);
      //print(i);
      for (var k in tf) {
        //print(k);

        if (k["word"] == i && k.containsKey(j)) {
          //print(tf[j] * idf[i]);
          w[j] = k[j] * idf[i];
          break;
        }
      }
    }
    listweight.add(w);
  }
  return listweight;
}

matching(var quary, var weigth) {
  var quarymatch = [];
  for (var i in quary) {
    for (var j in weigth) {
      if (i == j["word"]) {
        quarymatch.add(j);
      }
    }
  }
  print(quarymatch);
  return quarymatch;
}

Similarity(var numquary, var name) {
  var sim = {};
  for (var i in numquary) {
    int c = 0;
    for (var j in name) {
      if (sim.containsKey(j) == false) {
        sim[j] = i[j];
      } else {
        c = c + 1;
        sim[j] = (i[j] + sim[j]) / c;
      }
    }
  }
  return sim;
}

ranking(var similaryty, var name) {
  var max_answer = {};
  max_answer["name"] = "";
  max_answer["score"] = -100;
  for (var i in name) {
    if (max_answer["score"] < similaryty[i]) {
      max_answer["score"] = similaryty[i];
      max_answer["name"] = i;
    }
  }
  return max_answer;
}
