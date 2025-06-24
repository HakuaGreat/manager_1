class SubscriptionService {
  final String name;
  final List<String> intervals;
  final List<SubscriptionPlan> plans;
  final String? loginUrl; // ← 追加

  SubscriptionService({
    required this.name,
    required this.intervals,
    required this.plans,
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
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: 'ベーシック', price: 990),
      SubscriptionPlan(name: 'スタンダード', price: 1490),
      SubscriptionPlan(name: 'プレミアム', price: 1980),
    ],
    loginUrl: 'https://www.netflix.com/login', // 追加
  ),
  SubscriptionService(
    name: 'Amazon Prime',
    intervals: ['月毎', '年毎'],
    plans: [
      SubscriptionPlan(name: '通常', price: 600),
    ],
    loginUrl: 'https://www.amazon.co.jp/',
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

  // ホロライブ関連のサブスクリプションサービス
  SubscriptionService(
    name: 'ホロライブ「ときのそら」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'そらとも', price: 290),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCp6993wxpyDPHUpavwDFqgg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「ロボ子さん」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '★ろぼさーへ★', price: 490),
      SubscriptionPlan(name: '★高性能ろぼさーへ★', price: 1190),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCDqI2jOz0weumE8s7paEk6g/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「さくらみこ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'さくら組', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC-hM6YJuNYVAmUWxeIr9FeA/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「星街すいせい」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'コールをする！Lv1', price: 390),
      SubscriptionPlan(name: 'サイリウムをふる！Lv2', price: 1190),
      SubscriptionPlan(name: 'フラスタをおくる！Lv3', price: 2990),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「AZKi」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '開拓者組合', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC0TXe_LYZ4scaW2XMyi5_kw/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「アキ・ローゼンタール」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'ロゼ隊の宿付き酒場', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCFTLzh12_nrtzqBPsTCqenA/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「赤井はあと」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'はあとんランド🐷HAATON LAND', price: 490),
      SubscriptionPlan(name: '養豚場🥓PIG FARM', price: 690),
      SubscriptionPlan(name: '豚箱📦️PIG BOX', price: 1190),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC1CfXB_kRs3C-zaeTG3oGyg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「白上フブキ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'WELCOME TO KINGDOM', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCdn5BQ06XqgXoAxIhbqw5Rg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「夏色まつり」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'うどん', price: 490),
      SubscriptionPlan(name: 'ハンバーグ', price: 790),
      SubscriptionPlan(name: '焼き肉', price: 2990),
      SubscriptionPlan(name: 'うにさんど', price: 12000),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCQ0UDLQCjY0rmuxCDE38FGg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「百鬼あやめ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '百鬼組', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC7fk0CB07ly8oSl0aqKkqFg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「癒月ちょこ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '設定なし(豆ンバー)', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC1suqwovbL1kzsoaZgFZLKg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「大空スバル」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'スバ友マンバー', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCvzGlP9oQwU--Y0r9id_jnA/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「大神ミオ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'ミオファの森のミオファ', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCp-5t9SrOQwXMU7iIjQfARg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「猫又おかゆ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'おにぎりゃーの牢屋', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCvaTdHTWBGv3MKj3KVqJVCw/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「戌神ころね」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '生贄の祭壇', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UChAnqc_AY5_I3Px5dig3X1Q/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「兎田ぺこら」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '兎田ふぁみりあ', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC1DCedRgGHBdm81E1llLhOQ/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「不知火フレア」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '止まり木', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCvInZx9h3jC2JzsIzoOebWg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「白銀ノエル」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '白銀愛好会', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCdyqAaZDKHXg4Ahi7VENThQ/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「宝鐘マリン」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '宝鐘海賊団', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCCzUftO8KOVkV4wQG1vkUvg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「天音かなた」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'へい民', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCZlDXzGoo7d44bwdNObFacg/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「角巻わため」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'Member Sheep', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCqm3BQLlJfvkTsX_hvm0UmA/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「常闇トワ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '常闇Family', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC1uv2Oq6kNxgATlCiez59hw/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「姫森ルーナ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'ルーナイトへようこそなのら', price: 490),
      SubscriptionPlan(name: 'ルーナイト御意へようこそなのら', price: 1190),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCa9Y57gfeY0Zro_noHRVrnw/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「雪花ラミィ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'もちもちだいふく', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCFKOVgVbGmX65RxO3EtH3iw/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「桃鈴ねね」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'ねねプロダクション', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCAWSyEs_Io8MtpY3m-zqILA/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「獅白ぼたん」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'ししろぼ団【SSRB】', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCUKD-uaobj9jiqB-VXt71mA/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「尾丸ポルカ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'おまる座', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCK9V2B22uJYu3N7eR_BT9QA/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「ラプラス・ダークネス」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '貴様ら', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCENwRMx5Yh42zWpzURebzTw/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「鷹嶺ルイ」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '幹部PON`s', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCs9_O1tRPMQTHQ-N_L6FU2g/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「博衣こより」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'こよりの研究所', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC6eWCld0KwmyHFbAqK3V-Rw/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「風真いろは」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: 'かざま隊', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UC_vMYWcDjmfdpH6r4TTn1MQ/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「火威青」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '青の本棚', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCMGfV7TVTmHhEErVJg1oHBQ/join', // 追加
  ),
  SubscriptionService(
    name: 'ホロライブ「音乃瀬奏」',
    intervals: ['月毎'],
    plans: [
      SubscriptionPlan(name: '音の勢', price: 490),
    ],
    loginUrl: 'https://www.youtube.com/channel/UCWQtYtq9EOB4-I5P-3fh8lA/join', // 追加
  ),
];