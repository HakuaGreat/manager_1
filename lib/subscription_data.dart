class SubscriptionService {
  final String name;
  final List<String> intervals;
  final List<SubscriptionPlan> plans;
  final List<SubscriptionPlan>? plansYear; // 年間プランを追加
  final String? loginUrl; // ← 追加

  SubscriptionService({
    required this.name,
    required this.intervals,
    required this.plans,
    this.plansYear,
    this.loginUrl,
  });
}

class SubscriptionPlan {
  final String name;
  final int price; // 円

  SubscriptionPlan({required this.name, required this.price});
}

final List<SubscriptionService> subscriptionServices = [
  SubscriptionService(
    name: 'Netflix',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'ベーシック', price: 890),
      SubscriptionPlan(name: 'スタンダード', price: 1590),
      SubscriptionPlan(name: 'プレミアム', price: 2290),
    ],
    loginUrl: 'https://www.netflix.com/login', // 追加
  ),
  SubscriptionService(
    name: 'Amazon Prime',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 600),
    ],
    plansYear: [
      SubscriptionPlan(name: '年払い', price: 5900),
    ],
    loginUrl: 'https://www.amazon.co.jp/',
  ),
  SubscriptionService(
    name: 'Discord Nitro', 
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: 'BASIC', price: 350),
      SubscriptionPlan(name: 'NITRO', price: 1050),
    ],
    plansYear: [
      SubscriptionPlan(name: 'BASIC 年間', price: 3500),
      SubscriptionPlan(name: 'NITRO 年間', price: 10500),
    ],
    loginUrl: 'https://discord.com/login', // 追加
  ),
  SubscriptionService(
    name: 'YouTube Premium',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: '個人', price: 1280),
      SubscriptionPlan(name: 'ファミリー', price: 2280),
      SubscriptionPlan(name: '学生', price: 780),
    ],
    loginUrl: 'https://www.youtube.com/premium',
  ),
  SubscriptionService(
    name: 'ニコニコ動画',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: 'クレカ払い', price: 790),
      SubscriptionPlan(name: 'Paidy', price: 790),
      SubscriptionPlan(name: 'Paypal', price: 790),
      SubscriptionPlan(name: 'キャリア決済', price: 790),
      SubscriptionPlan(name: 'Apple Account', price: 990),
      SubscriptionPlan(name: 'Google Play', price: 990),
    ],
    loginUrl: 'https://account.nicovideo.jp/login',
  ),
  SubscriptionService(
    name: 'Hulu',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 1026),
    ],
    loginUrl: 'https://www.hulu.jp/login',
  ),
  SubscriptionService(
    name: 'U-NEXT',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 2189),
    ],
    loginUrl: 'https://www.unext.jp/login',
  ),
  SubscriptionService( 
    name: 'DMM TV',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 550),
    ],
    loginUrl: 'https://www.dmm.com/my/-/login/'
  ),
  SubscriptionService(
    name: 'Disney+',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: 'スタンダード', price: 1140),
      SubscriptionPlan(name: 'プレミアム', price: 1520),
    ],
    loginUrl: 'https://www.disneyplus.com/login',
  ),
  SubscriptionService(
    name: 'Lemino',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'Leminoプレミアム', price: 990),
    ],
    loginUrl: 'https://lemino.docomo.ne.jp/', // 追加
  ),
  SubscriptionService(
    name: 'VR Square',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'AKB48+', price: 3980),
    ],
    loginUrl: 'https://vr-square.jp/login',
  ),
  SubscriptionService(
    name: 'Video Market',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'プレミアム', price: 550),
      SubscriptionPlan(name: 'プレミアム見放題', price: 1078),
    ],
    loginUrl: 'https://www.videomarket.jp/login',
  ),
  SubscriptionService(
    name: 'クランクイン！ビデオ',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 990),
    ],
    loginUrl: 'https://www.crank-in.net/login',
  ),
  SubscriptionService(
    name: 'FOD',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'FODプレミアム', price: 976),
    ],
    loginUrl: 'https://fod.fujitv.co.jp/s/login/',
  ),
  SubscriptionService(
    name: 'ABEMA',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'プレミアム', price: 1080),
    ],
    loginUrl: 'https://abema.tv/login',
  ),
  SubscriptionService(
    name: 'TELASA',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 990),
    ],
    loginUrl: 'https://www.telasa.jp/login', // 追加,
  ),
  SubscriptionService(
    name: 'dアニメストア',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 550),
    ],
    loginUrl: 'https://anime.dmkt-sp.jp/login',// 追加,
  ),
  SubscriptionService(
    name: 'BANDAI Channel',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 1100),
    ],
    loginUrl: 'https://www.b-ch.com/', // 追加
  ),
  SubscriptionService(
    name: 'アニメ放題',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 440),
    ],
    loginUrl: 'https://www.animehodai.jp/', // 追加
  ),
  SubscriptionService(
    name: 'のぎ動画',
    intervals: ['月毎'], 
    plans: [
      SubscriptionPlan(name: 'アプリ', price: 1700),
      SubscriptionPlan(name: 'Web', price: 1320),
    ],
    loginUrl: 'https://nogidoga.com/signin', // 追加
  ),
  SubscriptionService(
    name: '大阪チャンネル',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: 'FANY Channel', price: 480),
      SubscriptionPlan(name: 'よしもと劇場プレミアム', price: 1500),
      SubscriptionPlan(name: 'FANY + よしもと劇場プレミアム', price: 1980),
    ],
    loginUrl: 'https://osaka-channel.hikaritv.net/', // 追加
  ),
  SubscriptionService(
    name: 'AKB48グループ映像倉庫',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 1078),
    ],
    loginUrl: 'https://akb48group-eizo.jp/signin'
  ),
  SubscriptionService(
    name: 'DAZN',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: 'DAZN Global', price: 980),
      SubscriptionPlan(name: 'DAZN Standard', price: 4200),
    ],
    loginUrl: 'https://www.dazn.com/ja-JP/welcome' // 追加
  ),
  SubscriptionService(
    name: 'Apple TV+',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 900),
    ],
    loginUrl: 'https://tv.apple.com/jp/login' // 追加
  ),
  SubscriptionService(
    name: '東映特撮ファンクラブ',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 960),
    ],
  ),
  SubscriptionService(
    name: '将棋連盟中継アプリ',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 550),
    ],
  ),
  SubscriptionService(
    name: 'wowowオンデマンド',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 2530),
    ],
    loginUrl: 'https://auth.wowow.co.jp/realms/wip/protocol/openid-connect/auth?response_type=code&client_id=wol&redirect_uri=https%3A%2F%2Fmy.wowow.co.jp%2Fmember%2Flogin_postprocess.php%2Frd%2Fhttps%3A%2B%2Bwww.wowow.co.jp%2Blogin&scope=openid&code_challenge=Z6WpKWYvouOqIFcZPwN7YX8EEUbFAe62SNg6RJxhvj8&code_challenge_method=S256&state=41375246827676107981646943538454203480854650204483665285661065302243726886173936446468&nonce=18541635313569643342407247803840813318187945432063643485656674528577403069486660481968',// 追加
  ),
  SubscriptionService(
    name: 'Rakuten TV',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'Rakuten パ・リーグSpecial', price: 702),
      SubscriptionPlan(name: 'タカラヅカ・オン・デマンド', price: 1650),
      SubscriptionPlan(name: 'すみれの花咲くマンスリー', price: 880),
      SubscriptionPlan(name: 'アジア映画見放題',  price:880),
      SubscriptionPlan(name: 'アジアドラマ・プレミアム', price: 880),
      SubscriptionPlan(name: 'Lifetime', price: 550),
      SubscriptionPlan(name: 'HISTORY', price: 330),
      SubscriptionPlan(name: 'Vシネマ「極上！マンスリーパック」', price: 550),
      SubscriptionPlan(name: 'Rakuten TV 声優チャンネル', price: 550),
      SubscriptionPlan(name: '特選アニメ', price: 550),
      SubscriptionPlan(name: '特選キッズ', price: 550),
      SubscriptionPlan(name: 'AV見放題', price: 1760),
      ],
    loginUrl: 'https://tv.rakuten.co.jp/', // 追加
  ),
  SubscriptionService(
    name: 'music.jp',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 2000),
    ],
    loginUrl: 'https://music-book.jp/',
  ),
  SubscriptionService(
    name: 'SPOTV NOW',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 976),
    ],
    loginUrl:  'https://www.spotvnow.jp/intro' // 追加
  ),
  SubscriptionService(
    name: 'Jsportsオンデマンド',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '総合パック', price: 2640),
      SubscriptionPlan(name: '総合パック(U25割)', price: 1320),
      SubscriptionPlan(name: 'サッカー・フットサル', price: 1980),
      SubscriptionPlan(name: 'サッカー・フットサル(U25割)', price: 990),
      SubscriptionPlan(name: '野球', price: 1980),
      SubscriptionPlan(name: '野球(U25割)', price: 990),
      SubscriptionPlan(name: 'バスケットボール', price: 1980),
      SubscriptionPlan(name: 'バスケットボール(U25割)', price: 990),
      SubscriptionPlan(name: 'ラグビー', price: 1980),
      SubscriptionPlan(name: 'ラグビー(U25割)', price: 990),
      SubscriptionPlan(name: 'サイクルロードレース', price: 1980),
      SubscriptionPlan(name: 'サイクルロードレース(U25割)', price: 990),
      SubscriptionPlan(name: 'モータースポーツ', price: 1980),
      SubscriptionPlan(name: 'モータースポーツ(U25割)', price: 990),
      SubscriptionPlan(name: 'ウインタースポーツ', price: 1980),
      SubscriptionPlan(name: 'ウインタースポーツ(U25割)', price: 990),
      SubscriptionPlan(name: 'バドミントン', price: 1980),
      SubscriptionPlan(name: 'バドミントン(U25割)', price: 990),  
    ],
    loginUrl: 'https://www.jsports.co.jp/',// 追加
  ),
  SubscriptionService(
    name: 'Spotify',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'フリー', price: 0),
      SubscriptionPlan(name: 'プレミアム', price: 980),
    ],
    loginUrl: 'https://accounts.spotify.com/login', // 追加
  ),
  SubscriptionService(
    name: 'Apple Music',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '学生', price: 580),
      SubscriptionPlan(name: '個人', price: 1080),
      SubscriptionPlan(name: 'ファミリー', price: 1680),
    ],
    loginUrl: 'https://music.apple.com/jp/login', // 追加
  ),
  SubscriptionService(
    name: 'LINE MUSIC',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '一般', price: 1080),
      SubscriptionPlan(name: '一般(LINESTORE限定)', price: 980),
      SubscriptionPlan(name: '学生', price: 580),
      SubscriptionPlan(name: '学生(LINESTORE限定)', price: 480),
      SubscriptionPlan(name: 'ファミリー', price: 1480),
    ],
    loginUrl: 'https://music.line.me/login', // 追加
  ),
  SubscriptionService(
    name: 'AWA',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'フリー', price: 0),
      SubscriptionPlan(name: 'スタンダード', price: 980),
      SubscriptionPlan(name: 'スタンダード(学割)', price: 480),
      SubscriptionPlan(name: 'アーティスト(1組)', price: 270),
      SubscriptionPlan(name: 'アーティスト(2組)', price: 540),
      SubscriptionPlan(name: 'アーティスト(3組)', price: 810),
    ],
    loginUrl: 'https://awa.fm/login', // 追加
  ),
  SubscriptionService(
    name: 'dヒッツ',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 690),
    ],
    loginUrl: 'https://music.dmkt-sp.jp/login', // 追加
  ),
  SubscriptionService(
    name: 'Amazon Music Unlimited',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '個人', price: 1080),
      SubscriptionPlan(name: '学生', price: 580),
      SubscriptionPlan(name: 'Echo', price: 580),
      SubscriptionPlan(name: 'ファミリー', price: 1680),

    ],
    loginUrl: 'https://music.amazon.co.jp/login', // 追加
  ),
  SubscriptionService(
    name: 'YouTube Music',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '個人', price: 1080),
      SubscriptionPlan(name: 'ファミリー', price: 1680),
      SubscriptionPlan(name: '学生', price: 580),
    ],
    loginUrl: 'https://music.youtube.com/login', // 追加
  ),
  SubscriptionService(
    name: '楽天ミュージック',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'スタンダード', price: 980),
      SubscriptionPlan(name: '楽天カード・モバイル', price: 780),
      SubscriptionPlan(name: '学生', price: 480),
      SubscriptionPlan(name: 'ライト', price: 500),
      SubscriptionPlan(name: 'バンドル', price: 0)
    ],
    loginUrl: 'https://music.rakuten.co.jp/login', // 追加
  ),
  SubscriptionService(
    name: 'KKBOX',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 980),
    ],
    loginUrl: 'https://www.kkbox.com/jp/ja/login', // 追加
  ),
  SubscriptionService(
    name: 'Pontaパス',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'Pontaパス', price: 548),
      SubscriptionPlan(name: 'Pontaパスライト(新規受付終了)', price: 409),
    ],
    loginUrl: 'https://www.au.com/entertainment/smartpass/',
  ),
  SubscriptionService(
    name: 'コミックシーモア',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '読み放題ライト', price: 780),
      SubscriptionPlan(name: '読み放題フル', price: 1480),
    ],
    loginUrl: 'https://yomiho.cmoa.jp/', // 追加
  ),
  SubscriptionService(
    name: '楽天マガジン',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 572),
    ],
    loginUrl: 'https://magazine.rakuten.co.jp/', // 追加
  ),
  SubscriptionService(
    name: 'ブック放題',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 550),
    ],
    loginUrl: 'https://bookhodai.jp/', // 追加
  ),
  SubscriptionService(
    name: 'Kindle Unlimited',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 980),
    ],
    loginUrl: 'https://www.amazon.co.jp/kindle-dbs/hz/subscribe/ku',
  ),
  SubscriptionService(
    name: 'dマガジン',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 580),
    ],
    loginUrl: 'https://dmagazine.docomo.ne.jp/', // 追加
  ),
  SubscriptionService(
    name: 'いつでも書店',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '380円プラン(新規受付終了)', price: 418),
      SubscriptionPlan(name: '500円プラン', price: 550),
      SubscriptionPlan(name: '750円プラン', price: 825),
      SubscriptionPlan(name: '1000円プラン', price: 1100),
      SubscriptionPlan(name: '2000円プラン', price: 2200),
      SubscriptionPlan(name: '3000円プラン(新規受付終了)', price: 3300),
      SubscriptionPlan(name: '5000円プラン(新規受付終了)', price: 5500),
    ],
    loginUrl: 'https://itsudoco.com/',
  ),
  SubscriptionService(
    name: 'タブホ',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 550),
    ],
    loginUrl: 'https://tabuho-portal.optim.co.jp/account_login', // 追加
  ),
  SubscriptionService(
    name: 'audiobook.jp',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 833),
    ],
    loginUrl: 'https://audiobook.jp/login?ref=header&to=/' // 追加
  ),
  SubscriptionService(
    name: 'Audible',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 1500),
    ],
    loginUrl: 'https://www.audible.co.jp/', // 追加
  ),
  SubscriptionService(
    name: 'flier',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'シルバー', price: 550),
      SubscriptionPlan(name: 'ゴールド', price: 2200),
      SubscriptionPlan(name: '学割', price: 880),
    ],
    loginUrl: 'https://flierinc.com/', // 追加
  ),
  SubscriptionService(
    name: 'Shelff',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 3850),
    ],
    loginUrl: 'https://shelff.jp/', // 追加
  ),
  SubscriptionService(
    name: 'BEERACLE',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 6980),
    ],
    loginUrl: 'https://www.beeracle.jp/', // 追加
  ),
  SubscriptionService(
    name: 'TUTAYA DISCAS',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '定額レンタル4', price: 1100),
      SubscriptionPlan(name: '定額レンタル8ダブル', price: 2200),
      SubscriptionPlan(name: '定額レンタルMAX', price: 6600),
    ],
    loginUrl: 'https://movie-tsutaya.tsite.jp/netdvd/dvd/top.do', // 追加
  ),
  SubscriptionService(
    name: 'ぽすれん',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'スタンダード4', price: 990),
      SubscriptionPlan(name: 'スタンダード8', price: 2046),
      SubscriptionPlan(name: 'ダブル16', price: 4136),  
      SubscriptionPlan(name: 'トリプル24', price: 6204),
      SubscriptionPlan(name: 'スタンダード', price: 3850),
    ],
    loginUrl: 'https://posren.com/', // 追加
  ),
  SubscriptionService(
    name: '全自動DIGA定額利用サービス',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'DMR-2X203', price: 1540),
      SubscriptionPlan(name: 'DMR-4X403', price: 3410),
      SubscriptionPlan(name: '48ヶ月目以降', price: 330),
    ],
    loginUrl: 'https://ec-plus.panasonic.jp/store/page/sbsc/diga/', // 追加
  ),

  // クリエイティブ関連のサブスクリプションサービス
  SubscriptionService(
    name: 'Adobe Creative Cloud',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'フォトプラン', price: 2380),
      SubscriptionPlan(name: '単体アプリ', price: 3280),
      SubscriptionPlan(name: 'コンプリートプラン', price: 7780),
      SubscriptionPlan(name: '学生・教職員版', price: 2180),
      SubscriptionPlan(name: 'Acrobat', price: 1980),
    ],
    loginUrl: 'https://www.adobe.com/jp/'
  ),
  SubscriptionService(
    name: 'Clip Studio Paint',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: 'PRO 1デバイス', price: 480),
      SubscriptionPlan(name: 'PRO 2デバイス', price: 800),
      SubscriptionPlan(name: 'PRO プレミアム', price: 980),
      SubscriptionPlan(name: 'PRO スマートフォン', price: 100),
      SubscriptionPlan(name: 'EX 1デバイス', price: 980),
      SubscriptionPlan(name: 'EX 2デバイス', price: 1380),
      SubscriptionPlan(name: 'EX プレミアム', price: 1600),
      SubscriptionPlan(name: 'EX スマートフォン', price: 300),
    ],
    loginUrl: 'https://www.clipstudio.net/ja/login', // 追加
  ),
  SubscriptionService(
    name: 'U-FRET',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'U-FRETプレミアム', price: 980),
    ],
    loginUrl: 'https://www.ufret.jp/login.php', // 追加
  ),
  SubscriptionService(
    name: 'Chordify',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'Basic', price: 450),
      SubscriptionPlan(name: 'Premium', price: 800),
      SubscriptionPlan(name: 'Premium + Toolkit', price: 1250),
    ],
    loginUrl: 'https://chordify.net/' // 追加
  ),
  SubscriptionService(
    name: 'twitch',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'TURBO', price: 1737),
    ],
    loginUrl: 'https://www.twitch.tv/' // 追加
  ),
    // ホロライブ関連のサブスクリプションサービス
  SubscriptionService(
    name: 'ホロライブ メンバーシップ',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'そらとも', price: 290),
    ],
    loginUrl: 'https://www.youtube.com/', // 追加
  ),
];