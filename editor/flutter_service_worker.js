'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "2911539a586c528a532ae8210a196f63",
"index.html": "2dfbc8f130152a0219e6da8d4d5db24d",
"/": "2dfbc8f130152a0219e6da8d4d5db24d",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "67a26f3fe8af78efefc805f96492a998",
"assets/fonts/MaterialIcons-Regular.otf": "d1c0381d5e174bae0ae3ccfd933eb8f2",
"assets/NOTICES": "212dcb31847de6e50a8e6f4628b7e1df",
"assets/packages/ui_kit_library/assets/icons/search.svg": "2c9e35aa4ac8009b4f739107152f8ce3",
"assets/packages/ui_kit_library/assets/images/led_white_blink.svg": "4f4e39421c6ac172b6db9303a42a7f50",
"assets/packages/ui_kit_library/assets/images/modem_identifying.svg": "f3b9a713eaea6255ef91d860c5e10401",
"assets/packages/ui_kit_library/assets/images/img_place_wired_nodes.svg": "28eeb959f6f01ea45b4345596e4e8588",
"assets/packages/ui_kit_library/assets/images/linksys_wordmark.svg": "1f8aa6823d44a8d208a5c7161823db8c",
"assets/packages/ui_kit_library/assets/images/img_move_nodes.svg": "f15b36d90e7c0dc0425899f57bf01d45",
"assets/packages/ui_kit_library/assets/images/img_port_on.svg": "05e4f1e355f244f94104ced8c693c6e5",
"assets/packages/ui_kit_library/assets/images/devices_xl/router-ln12.png": "b7abead6fc098e3427844565060ec4eb",
"assets/packages/ui_kit_library/assets/images/devices_xl/router-mx6200.png": "eaabf376b969e86be1e81c48192085bc",
"assets/packages/ui_kit_library/assets/images/led_blue_blink.svg": "c315660e210d866808aa3ab7c372a584",
"assets/packages/ui_kit_library/assets/images/node_light_blink_white.svg": "19ae7bb16d35f61df15d8282eb080973",
"assets/packages/ui_kit_library/assets/images/fortinet_dns.png": "8e3a80571fd6dacbccf453abf5750c22",
"assets/packages/ui_kit_library/assets/images/node_light_solid_white.svg": "f90d528865ba264d0ab5973f671b882d",
"assets/packages/ui_kit_library/assets/images/node_light_blink_yellow.svg": "82f2772dcb5df121ac03075a415d0e9b",
"assets/packages/ui_kit_library/assets/images/no_internet_connection.svg": "faf740fc71382fbf89e4e2469cd519b2",
"assets/packages/ui_kit_library/assets/images/btn_check_speeds.svg": "fbd28d2acf8fa27e2fa24c18c00c1ae3",
"assets/packages/ui_kit_library/assets/images/node_light_off.svg": "12a60fe07c5087a658c09d4dcfc6e49b",
"assets/packages/ui_kit_library/assets/images/led_blue_solid.svg": "317c36483870c020d596f708af028a91",
"assets/packages/ui_kit_library/assets/images/node_light_blink_red.svg": "fd45ed85a2fdb0749fbc14ea44ecbb65",
"assets/packages/ui_kit_library/assets/images/linksys_logo_black.svg": "2d68eebf8216d142935b3124db069911",
"assets/packages/ui_kit_library/assets/images/node_light_solid_blue.svg": "c77cae7b2fbf450c3f668ac9c577080e",
"assets/packages/ui_kit_library/assets/images/node_light_solid_red.svg": "209ac242762c8b05c5c10aef18249f53",
"assets/packages/ui_kit_library/assets/images/img_wired_move_nodes.svg": "e3e60124a53725d765a3969ac719bb29",
"assets/packages/ui_kit_library/assets/images/led_red_blink.svg": "2ccff855036119e8ac65d8a50c7dce0a",
"assets/packages/ui_kit_library/assets/images/pnp_finish_desktop.svg": "46f573353a2cf16656f7e08104f93b98",
"assets/packages/ui_kit_library/assets/images/img_add_nodes.svg": "ddf4c5df4b33b539cc1327e350f2ce8c",
"assets/packages/ui_kit_library/assets/images/internet_to_device.svg": "f3cb1ffc7d0a63377a3f3e41e462d816",
"assets/packages/ui_kit_library/assets/images/modem_device.svg": "2a6f535dc84cac7b6b3cca7a1c735da3",
"assets/packages/ui_kit_library/assets/images/img_port_off.svg": "80c60bf023f07b73e8d2fb7308e50431",
"assets/packages/ui_kit_library/assets/images/internet_to_router.svg": "d67e638ec52ee01dd993c3c60ea81e4d",
"assets/packages/ui_kit_library/assets/images/speedtest_powered.png": "0c65eb140db451a570a6bdf0c44fefa7",
"assets/packages/ui_kit_library/assets/images/open_dns.png": "5b2b5dfdad3250c495cb7646221b024b",
"assets/packages/ui_kit_library/assets/images/led_red_solid.svg": "08e1eac186de016023931e33ae40390d",
"assets/packages/ui_kit_library/assets/images/led_purple_blink.svg": "f6a6340075463eb8d66c7dfaf4f65b72",
"assets/packages/ui_kit_library/assets/images/modem_waiting.svg": "c3049bf966cfb40d077aae7e9cddaccf",
"assets/packages/ui_kit_library/assets/images/led_white_solid.svg": "4ccd5ecc34c9d2bd4952217e069cb309",
"assets/packages/ui_kit_library/assets/images/node_light_blink_blue.svg": "327d6bdb50662ec9de7ea552594aa7b5",
"assets/packages/ui_kit_library/assets/images/img_router_white.svg": "b37006eb165b18113a6e4734bdbd459d",
"assets/packages/ui_kit_library/assets/images/led_purple_solid.svg": "6db8298e1f46d5e15dc9d2c0bd3c3591",
"assets/packages/ui_kit_library/assets/images/led_yellow_solid.svg": "5b488e102502fce1ca72eb4fd872642f",
"assets/packages/ui_kit_library/assets/images/devices/router-ln12.png": "ab4382be7401a2b5be005e74d5ae483f",
"assets/packages/ui_kit_library/assets/images/devices/router-ea8300.png": "afe1da7ee5ccdf436fb4cd2cf437a2c9",
"assets/packages/ui_kit_library/assets/images/devices/router-ln11.png": "304d9de60d4ab7b8ddebef296396c5f7",
"assets/packages/ui_kit_library/assets/images/devices/router-mr7350.png": "f5babb3f54e2f174b7e157f6f9de04d9",
"assets/packages/ui_kit_library/assets/images/devices/router-whw01.png": "a8504ab2320dbea21dc3946e10cd22c1",
"assets/packages/ui_kit_library/assets/images/devices/router-mx5300.png": "7ddd2d1ed273fcf1624d783d9dad20ca",
"assets/packages/ui_kit_library/assets/images/devices/router-whw01b.png": "a2e0998951b26f9ae8efb6f4606ff783",
"assets/packages/ui_kit_library/assets/images/devices/router-mr7500.png": "f7c87e0bc7b8a2cbfef16adb6819199b",
"assets/packages/ui_kit_library/assets/images/devices/router-whw03.png": "033480ed0bb77410fd9c4b28ca68c4ea",
"assets/packages/ui_kit_library/assets/images/devices/router-mx6200.png": "0fad08765ac0240d59377d5aa309f59c",
"assets/packages/ui_kit_library/assets/images/devices/router-mr6350.png": "1175540cb29f7d02458376bd56a93624",
"assets/packages/ui_kit_library/assets/images/devices/router-whw01p.png": "7924fa7bca909628041814bc6b3e0442",
"assets/packages/ui_kit_library/assets/images/devices/router-ea9350.png": "d09420845a43053d70c023ada154c7c0",
"assets/packages/ui_kit_library/assets/images/devices/router-whw03b.png": "7cdf1767595b9a907b616c02b421fde7",
"assets/packages/ui_kit_library/assets/images/modem_plugged.svg": "c012a64cd122a792e3a78b4e6e887f75",
"assets/packages/ui_kit_library/assets/images/img_router_black.svg": "cb0ddf95e3f13690b22abff19aa39770",
"assets/packages/ui_kit_library/assets/images/chrome_privacy_err.png": "25a6cdc27c88e7eab329c801fa0e45fd",
"assets/packages/ui_kit_library/assets/fonts/NeueHaasGrotTextRound-75Bold.otf": "a8e5075453912b09efc13ff960405a52",
"assets/packages/ui_kit_library/assets/fonts/NeueHaasGrotTextRound-55Roman.otf": "c921fd69f60ca8bd00dbb9bc224fb03f",
"assets/packages/ui_kit_library/assets/fonts/LinksysIcons.otf": "9b560e666ac815fc5beaaabc9d0a4cf3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/FontManifest.json": "70d846945bc9f080af447e9869605646",
"assets/AssetManifest.bin": "f2cbb012c57fc01fe50fbd600b661acb",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "fb9d06488f1a4ac127c9b409b5c7f1b0",
"version.json": "7e71a02f79177e62ed954a36dd737f63",
"main.dart.js": "17c2a67ccda7936da19ef1102742a4e8"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
