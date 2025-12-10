import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MyMarker {
  LatLng operator [](String other) {
    throw UnimplementedError('operator [] is not implemented');
  }
}

final List<Map<String, dynamic>> arabicData = [
  {
    "id": 1,
    "name": ' الزبارة',
    "icon": Icons.location_on_outlined,
    "color": Colors.black,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1700649525/WebSite%20Images/Alzubara%20image/zubara_site1_w3nkod.jpg',
    "point": LatLng(25.9771068, 51.0453357),
    "title": " أطلال الزبارة",
    "description": "Al Zubara \n a UNESCO World Heritage Site Al Zubara Fort.",
    "uri": 'https://maps.app.goo.gl/vsWXp3FDU466GFgA8',
  },

  {
    "id": 2,
    "name": 'عين محمد',
    "icon": Icons.location_on_outlined,
    "color": Colors.black,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1686040905/WebSite%20Images/Sites/AinMhd-1_ijee12.jpg',
    "point": LatLng(26.0037699, 51.0553029),
    "title": "قرية عين محمد",
    "description": "Ain Mohamed, a historical site",
    "uri": 'https://maps.app.goo.gl/saYjgViVRLhkb63v6',
  },

  {
    "id": 3,
    "name": 'Lujmail - الجميل',
    "icon": Icons.location_on,
    "color": const Color.fromARGB(255, 244, 54, 235),
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1686040918/WebSite%20Images/Sites/Lejmail-5_dgazav.jpg',
    "point": LatLng(26.0858459, 51.1570112),
    "title": "Lujmail - الجميل",
    "description": "Lujmail, a historical site",
    "uri": 'https://maps.app.goo.gl/Rv3fxrNKxemHkvnU8',
  },

  {
    "id": 4,
    "name": 'Al Mfjar - المفجر',
    "icon": Icons.location_on_outlined,
    "color": const Color.fromARGB(255, 221, 234, 218),
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1689241336/WebSite%20Images/Sites/grid_landscape_nqvxkr.jpg',
    "point": LatLng(26.134798, 51.303231),
    "title": "Al Mfjar - المفجر",
    "description": "Al Mfjar, a city with rich history",
    "uri": 'https://maps.app.goo.gl/14sRaKN5J9JkkwrV7',
  },

  
  {  "id": 5,
    "name": 'Marwab - مروب',
    "icon": Icons.location_on_outlined,
    "color": const Color.fromARGB(255, 73, 244, 54),
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1686040909/WebSite%20Images/Sites/Marwab-1_utnof1.jpg',
    "point": LatLng(25.859765, 51.0314829),
    "title": "Marwab - حصن مروب",
    "description": "Marwab, a city with rich history",
    "uri": 'https://maps.app.goo.gl/ih9p9YhPWcNUkx2e9',
  },

  {
    "id": 6,
    "name": 'Zkreet - زكريت',
    "icon": Icons.location_on_outlined,
    "color": Colors.purpleAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1686040903/WebSite%20Images/Forts/zekreet-1_gdbkjt.jpg',
    "point": LatLng(25.490230, 50.844352),
    "title": "Zkreet - زكريت",
    "description": "Zkreet, a city with rich history",
    "uri": 'https://maps.app.goo.gl/bS5Gd11cQq5Vtp7G8',},
  
  
    {"id": 7,
    "name": 'Al Rekayat - الركيات',
    "icon": Icons.location_on_outlined,
    "color": Colors.black,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1745998509/Al%20Rekayat/Rekayat_11_bvganc.jpg',
    "point": LatLng(26.0505741, 51.1461329),
    "title": "Al Rekayat - الركيات",
    "description": "Al Jassasiya, a city with rich history",
    "uri": 'https://maps.app.goo.gl/vPXFSZ4SSroUzJZo7',},
  
  
  {  "id": 8,
    "name": 'Al Thaqab - الثقب',
    "icon": Icons.location_on_outlined,
    "color": Colors.blue,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1745998498/Al%20Thaghab/Thaghab02_vwux6w.jpg',
    "point": LatLng(26.0327713, 51.1196932),
    "title": "Al Thaqab - الثقب",
    "description": "Al Thaqab, a city with rich history",
    "uri": 'https://maps.app.goo.gl/kiGKe3uMKSsk8z2WA',},


  {  "id": 9,
    "name": 'Barazan - برزان',
    "icon": Icons.location_on_outlined,
    "color": Colors.green,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1745998499/Burj%20Barzan/Barzan_05_fy3k8w.jpg',
    "point": LatLng(25.4181672, 51.4147444),
    "title": "Barazan - برزان",
    "description": "Barazan, a city with rich history",
    "uri": 'https://maps.app.goo.gl/N9XzqqdpaYtxiyT37',},


  {  "id": 10,
    "name": 'Al Jassasiya - الجساسية',
    "icon": Icons.location_on_outlined,
    "color": Colors.red,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758212980/icon1_o4h8lv.png',
    "point": LatLng(25.9524633, 51.4060351),
    "title": "Al Jassasiya - الجساسية",
    "description": "Al Jassasiya, a city with rich history",
    "uri": 'https://maps.app.goo.gl/gaXvmpr78nBYpPsX8',
  },

  {
    "id": 11,
    "name": 'Al Asaila - العسيلة',
    "icon": Icons.location_on_outlined,
    "color": Colors.blueAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758820536/Paleolithic/Asaila/Asaila-3_awqi1d.jpg',
    "point": LatLng(25.2951835, 50.9232741),
    "title": "Al Asaila - العسيلة",
    "description": "Al Asaila, a city with rich history",
    "uri": 'https://maps.app.goo.gl/bug46SNJMo32Koft5',
  },

  {
    "id": 12,
    "name": 'Wadi Al Jalta - وادي الجلته',
    "icon": Icons.location_on_outlined,
    "color": Colors.blueAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758820537/Paleolithic/Wadi%20Al%20Jalta/WadiAlJalta-1_toaicy.jpg',
    "point": LatLng(25.406283, 51.219643),
    "title": "Wadi Al Jalta - وادي الجلته",
    "description": "Wadi Al Jalta, a city with rich history",
    "uri": 'https://maps.app.goo.gl/3gk3v4f6mYfX4FhE6',
  },

  {
    "id": 13,
    "name": 'Ras Broog - رأس أبروق',
    "icon": Icons.location_on_outlined,
    "color": Colors.purpleAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.6062775, 50.8357083),
    "title": "Ras Broog -  رأس بروق",
    "description": "Ras Broog, a city with rich history",
    "uri": 'https://maps.app.goo.gl/NJLpbxyVd6BWPdHL8',
  },

  {
    "id": 14,
    "name": 'Shagra - شقرا',
    "icon": Icons.location_on_outlined,
    "color": Colors.purpleAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758888598/Neolithic/Shagra/Shagra-3_qdhku0.jpg',
    "point": LatLng(24.8233297, 51.3890422),
    "title": "Shagra - شقرا",
    "description": "Shagra, a city with rich history",
    "uri": 'https://maps.app.goo.gl/c7i1ELokVPoQTZt46',
  },

  {
    "id": 15,
    "name": 'Ejbaijeb - إجبيجب',
    "icon": Icons.location_on_outlined,
    "color": Colors.purpleAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.2221325, 50.8627177),
    "title": "Ejbaijeb - إجبيجب",
    "description": "Ejbaijeb, a city with rich history",
    "uri": 'https://maps.app.goo.gl/JRuVsSSbJBX2uy6g7',
  },

  {
    "id": 16,
    "name": 'Al Ezairiq - الزرقاء',
    "icon": Icons.location_on_outlined,
    "color": Colors.purpleAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758218610/Neolithic/Ezairiq/Ezairiq-4_dnpgxx.jpg',
    "point": LatLng(24.9833515, 51.3897002),
    "title": "Al Ezairiq - الزرقاء",
    "description": "Al Ezairiq, a city with rich history",
    "uri": 'https://maps.app.goo.gl/m3Xadc3sC6WZNC93A',
  },

  {
    "id": 17,
    "name": 'Al Refaig - ارفيق',
    "icon": Icons.location_on_outlined,
    "color": Colors.purpleAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.5257529, 50.9803782),
    "title": "Al Refaig - ارفيق",
    "description": "Al Refaig, a city with rich history",
    "uri": 'https://maps.app.goo.gl/8mXo9v4gk3r8vYhF6',
  },

  {
    "id": 18,
    "name": 'Daasa - دعسة',
    "icon": Icons.location_on_outlined,
    "color": Colors.purpleAccent,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758878595/Neolithic/Daasa/Daasa-1_uomve7.jpg',
    "point": LatLng(25.3545624, 50.7654645),
    "title": "Daasa - دعسة",
    "description": "Daasa, a city with rich history",
    "uri": 'https://maps.app.goo.gl/3gk3v4f6mYfX4FhE6',
  },

{
    "id": 19,
    "name": 'Al Mazrooah - المزروعة',
    "icon": Icons.location_on_outlined,
    "color": Colors.orange,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758898796/Mazrooah/Mazrooah-2_donpod.jpg',
    "point": LatLng(25.439994, 51.382092),
    "title": "Al Mazrooah - المزروعة",
    "description": "Al Mazrooah, a city with rich history",
    "uri": 'https://maps.app.goo.gl/mSSsiUcPxA8aeFwz9',
  },

  {
    "id": 20,
    "name": 'Ras Al Matbakh - رأس المطبح',
    "icon": Icons.location_on_outlined,
    "color": Colors.orange,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1716804415/Ras_Matbakh_qqulwe.jpg',
    "point": LatLng(25.721184, 51.585194),
    "title": "Ras Al Matbakh - رأس المطبح",
    "description": "Ras Al Matbakh, a city with rich history",
    "uri": 'https://maps.app.goo.gl/aTA2nrq5gd7iZewg9',
  },

  {
    "id": 21,
    "name": 'Umm Al Maa - أم الماء',
    "icon": Icons.location_on_outlined,
    "color": Colors.orange,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.771377, 50.993778),
    "title": "Umm Al Maa - أم الماء",
    "description": "Umm Al Maa, a city with rich history",
    "uri": 'https://maps.app.goo.gl/mvvNbQqFg1sRDMUm9',
  },

  {
    "id": 22,
    "name": 'Ras Owainat Ali - رأس عوينات علي',
    "icon": Icons.location_on_outlined,
    "color": Colors.white,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.5048156, 50.80015),
    "title": "Ras Owainat Ali - رأس عوينات علي",
    "description": "Ras Owainat Ali, a city with rich history",
    "uri": 'https://maps.app.goo.gl/3mXhY3v1v4Y6m4tD8',
  },

  {
    "id": 23,
    "name": 'Jazirat Bin Ghannam-  جزيرة بن غنام',
    "icon": Icons.location_on,
    "color": Colors.white,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1716804415/Jazirat_Bin_Ghannam_jdmzhj.jpg',
    "point": LatLng(25.693129, 51.5488285),
    "title": "Jazirat Bin Ghannam-  جزيرة بن غنام",
    "description": "Jazirat Bin Ghannam, a city with rich history",
    "uri": 'https://maps.app.goo.gl/976q3ys6o4DKTddD8',
  },

  {
    "id": 24,
    "name": 'Al Wusail -  الوسيل',
    "icon": Icons.location_on,
    "color": Colors.white,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.5047166, 51.4732975),
    "title": "Al Wusail -  الوسيل",
    "description": "Al Wusail, a city with rich history",
    "uri": 'https://maps.app.goo.gl/abfhKySAYR6HoRNW9',
  },
    {
    "id": 25,
    "name": 'Wadi Al Debaian -  وادي الدبيان',
    "icon": Icons.location_on,
    "color": Colors.white,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.9498054,51.0226641),
    "title": "Wadi Al Debaian -  وادي الدبيان",
    "description": "Wadi Al Debaian, a city with rich history",
    "uri": 'https://maps.app.goo.gl/M5qrnW9RWw71bVKNA',
  },
  {
    "id": 26,
    "name": 'Ras Eshairij - رأس إيشيريج',
    "icon": Icons.location_on,
    "color": Colors.white,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(25.959906, 50.994787),
    "title": "Ras Eshairij - رأس إيشيريج",
    "description": "Ras Eshairij, a city with rich history",
    "uri": 'https://maps.app.goo.gl/67qMxeA5qdFEbxJFA',
  },
  {
    "id": 27,
    "name": 'Al Yousetiya - اليوستية',
    "icon": Icons.location_on,
    "color": Colors.white,
    "img":
        'https://res.cloudinary.com/dmklduciw/image/upload/v1758880239/not_found_rpvaj7.png',
    "point": LatLng(26.1136962,51.1719722),
    "title": "Al Yousetiya - اليوستية",
    "description": "Al Yousetiya, a city with rich history",
    "uri": 'https://maps.app.goo.gl/QUo9K4RUU43FkQiK7',
  },
  
];
String? selectedValue; 

/* Removed invalid extension method that caused a syntax error */


