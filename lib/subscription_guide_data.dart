class SubscriptionGuideInfo {
  final String name;
  final String description;
  final String url;
  final List<String> categories;
  final String? logoAsset; // ロゴ画像パスを追加

  const SubscriptionGuideInfo({
    required this.name,
    required this.description,
    required this.url,
    required this.categories,
    this.logoAsset,
  });
}

const List<SubscriptionGuideInfo> subscriptionGuideInfos = [
  SubscriptionGuideInfo(
    name: 'Netflix',
    description: '映画やドラマが見放題の動画配信サービス。',
    url: 'https://www.netflix.com/jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/netflix.png',
  ),
  SubscriptionGuideInfo(
    name: 'Spotify',
    description: '音楽が聴き放題のストリーミングサービス。',
    url: 'https://www.spotify.com/jp/',
    categories: ['音楽', 'エンタメ'],
    logoAsset: 'assets/logos/spotify.png',
  ),
  SubscriptionGuideInfo(
    name: 'Amazon Prime',
    description: '動画、音楽、配送特典などが利用できる総合サービス。',
    url: 'https://www.amazon.co.jp/amazonprime/',
    categories: ['総合', '動画配信', '音楽'],
    logoAsset: 'assets/logos/amazon_prime.png',
  ),
  SubscriptionGuideInfo(
    name: 'YouTube Premium',
    description: '広告なしでYouTubeを楽しめるプレミアムサービス。',
    url: 'https://www.youtube.com/premium',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/youtube_premium.png',
  ),
  SubscriptionGuideInfo(
    name: 'ニコニコ動画',
    description: '動画共有サイトで、コメント機能が特徴。※WebMoney,チケットでの支払い方法は当アプリでは非対応です。',
    url: 'https://www.nicovideo.jp/',
    categories: ['動画配信', 'ライブ配信', 'イラスト・漫画'],
    logoAsset: 'assets/logos/niconico.png',
  ),
  SubscriptionGuideInfo(
    name: 'Hulu',
    description: '映画やドラマが見放題の動画配信サービス。',
    url: 'https://www.hulu.jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/hulu.png',
  ),
  SubscriptionGuideInfo(
    name: 'U-NEXT',
    description: '映画、ドラマ、アニメが見放題の動画配信サービス。',
    url: 'https://www.unext.jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/unext.png',
  ),
  SubscriptionGuideInfo(
    name: 'DMM TV',
    description: '映画、ドラマ、アニメが見放題の動画配信サービス。',
    url: 'https://tv.dmm.com/vod/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/dmmtv.png',
  ),
  SubscriptionGuideInfo(
    name: 'Disney+',
    description: 'ディズニー、ピクサー、マーベルなどの映画が見放題。',
    url: 'https://www.disneyplus.com/ja-jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/disney_plus.png',
  ),
  SubscriptionGuideInfo(
    name: 'Lemino',
    description: '映画、ドラマ、アニメが見放題の動画配信サービス。',
    url: 'https://lemino.docomo.ne.jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/lemino.png',
  ),
  SubscriptionGuideInfo(
    name: 'VR Square',
    description: 'VRコンテンツが楽しめる動画配信サービス。',
    url: 'https://livr.jp/',
    categories: ['動画配信', 'VR'],
    logoAsset: 'assets/logos/vr_square.png',
  ),
  SubscriptionGuideInfo(
    name: 'Video Market',
    description: '映画、ドラマ、アニメが見放題の動画配信サービス。',
    url: 'https://www.videomarket.jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/video_market.png',
  ),
  SubscriptionGuideInfo(
    name: 'クランクイン！ビデオ',
    description: '映画、ドラマ、アニメが見放題の動画配信サービス。',
    url: 'https://video.crank-in.net/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/crank_in.png',
  ),
  SubscriptionGuideInfo(
    name: 'FOD',
    description: 'フジテレビの動画が見放題のサービス。',
    url: 'https://fod.fujitv.co.jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/fod.png',
  ),
  SubscriptionGuideInfo(
    name: 'ABEMA',
    description: 'ニュース、ドラマ、アニメが楽しめる動画配信サービス。',
    url: 'https://abema.tv/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/abema.png',
  ),
  SubscriptionGuideInfo(
    name: 'TELASA',
    description: 'テレビ朝日の動画が見放題のサービス。',
    url: 'https://www.telasa.jp/',
    categories: ['動画配信', 'エンタメ'],
    logoAsset: 'assets/logos/telasa.png',
  ),
  SubscriptionGuideInfo(
    name: 'dアニメストア',
    description: 'アニメ専門の動画配信サービス。',
    url: 'https://anime.dmkt-sp.jp/',
    categories: ['動画配信', 'アニメ'],
    logoAsset: 'assets/logos/d_anime.png',
  ),
  SubscriptionGuideInfo(
    name: 'BANDAI Channel',
    description: 'バンダイのアニメや特撮が見放題のサービス。',
    url: 'https://www.b-ch.com/',
    categories: ['動画配信', 'アニメ'],
    logoAsset: 'assets/logos/bandai_channel.png',
  ),
  SubscriptionGuideInfo(
    name: 'アニメ放題',
    description: 'アニメ専門の動画配信サービス。',
    url: 'https://www.animehodai.jp/',
    categories: ['動画配信', 'アニメ'],
    logoAsset: 'assets/logos/anime_houdai.png',
  ),
];