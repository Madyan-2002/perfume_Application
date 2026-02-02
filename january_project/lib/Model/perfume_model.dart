final List<String> categories = [
  'All',
  'Men',
  'Women',
  'Packages',
  'Kids',
  'Hair',
  'Body',
];

class PerfumeModel {
  final String image;
  final String name;
  final double price;
  final String description;
  final bool isFav;
  final String category;

  PerfumeModel({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    this.isFav = false,
    required this.category,
  });

  // PerfumeModel copyWith({
  //   String? image,
  //   String? name,
  //   double? price,
  //   String? description,
  //   bool? isFav,
  //   String? category,
  // }) {
  //   return PerfumeModel(
  //     image: image ?? this.image,
  //     name: name ?? this.name,
  //     price: price ?? this.price,
  //     description: description ?? this.description,
  //     category: category ?? this.category,
  //     isFav: isFav ?? this.isFav,
  //   );
  // }
}

List<PerfumeModel> perfumesList = [
  PerfumeModel(
    image: 'assets/images/1.jpeg',
    name: 'L’INSTANT HOME',
    price: 165,
    category: 'Men',
    isFav: false,
    description:
        '''ABOUT THE FRAGRANCE:L’Instant de Guerlain pour Homme highlights a unique moment: the one in which a man takes the initiative and after which everything will be different.This woody, sparkling, seductive fragrance was composed of contrasts. It is nothing less than surprising.''',
  ),

  PerfumeModel(
    image: 'assets/images/2.jpeg',
    name: 'Dior Homme',
    price: 117,
    category: 'Men',
    isFav: false,
    description:
        '''The quintessence of prestige and sophistication in a generous and powerful Eau de Parfum.Intense Iris, enhanced by a sensual amber facet and precious wood base, exudes its powerful charm.A sensual interpretation with a fragrant trail that is an invitation.''',
  ),

  PerfumeModel(
    image: 'assets/images/3.jpeg',
    name: 'Gentleman Réserve Privée',
    price: 123,
    category: 'Men',
    isFav: false,
    description:
        '''Discover Givenchy Gentleman Reserve Privée Eau de Parfum, the unique floral-woody fragrance inspired by the ultimate refinement of smooth, aromatic whisky.Co-created by master distillers and master perfumers, the savoir-faire of two olfactory worlds is combined to create an intense men’s cologne for strong and sophisticated gentlemen.''',
  ),

  PerfumeModel(
    image: 'assets/images/4.jpeg',
    name: 'Code Parfum',
    price: 165,
    category: 'Men',
    isFav: false,
    description:
        '''Strong yet sensitive, ARMANI CODE PARFUM reinvents the olfactory signature of the original ARMANI CODE fragrance.Retaining its woody aromatic,This is expressed in the fragrance's aromatic top notes and powerfully masculine base notes.ARMANI CODE PARFUM, the new powerful yet sensitive olfactory signature.''',
  ),

  PerfumeModel(
    image: 'assets/images/5.jpeg',
    name: 'Sauvage',
    price: 117,
    category: 'Men',
    isFav: false,
    description:
        '''A radically fresh composition, dictated by a name that has the ring of a manifesto.That was the way Francois Demachy, Dior Perfumer-Creator, wanted it: raw and noble all at once.Natural ingredients, selected with extreme care, prevail in excessive doses.''',
  ),

  PerfumeModel(
    image: 'assets/images/6.jpeg',
    name: 'BLEU DE CHANEL',
    price: 113,
    category: 'Men',
    isFav: false,
    description:
        '''An ode to masculine freedom expressed in an aromatic-woody fragrance with a captivating trail.A timeless scent housed in a bottle of deep and mysterious blue.''',
  ),

  PerfumeModel(
    image: 'assets/images/7.jpeg',
    name: 'Ombré Leather',
    price: 123,
    category: 'Men',
    isFav: false,
    description:
        '''A floral leather and cool spices reveal an untethered fragrance scent for men and women.Vast, Untethered,The fragrance reveals itself like a landscape in layers,Black leather is accompanied by spicy and florals notes of cardamom, jasmine sambac, patchouli, white moss, and amber.''',
  ),

  PerfumeModel(
    image: 'assets/images/8.jpeg',
    name: 'Libre Intense Eau de Parfum',
    price: 169,
    category: 'Women',
    isFav: false,
    description:
        '''The signature notes of lavender essence from France and Moroccan orange blossom combine with glowing orchid and warm vanilla to push the perfume to the extreme.It is a long-lasting unique twist on the floral fragrance.''',
  ),

  PerfumeModel(
    image: 'assets/images/9.jpeg',
    name: 'Miss Rose N Roses',
    price: 137,
    category: 'Women',
    isFav: false,
    description:
        '''Launch year: 2020. Top notes:Bergamot, Italian mandarin, Geranium. Heart notes: Grasse rose, Damask rose. Base notes: White musks.Design house: Christian Dior. Scent name: Miss Dior Rose N'roses.''',
  ),

  PerfumeModel(
    image: 'assets/images/10.jpeg',
    name: 'CHANCE',
    price: 160,
    category: 'Women',
    isFav: false,
    description:
        '''A floral fragrance in a round bottle.Unpredictable, in perpetual movement, CHANCE sweeps you into its whirlwind of happiness and fantasy.An olfactory encounter with chance.''',
  ),

  PerfumeModel(
    image: 'assets/images/11.jpeg',
    name: 'J’adore l’Or',
    price: 225,
    category: 'Women',
    isFav: false,
    description:
        '''J'adore Eau de Parfum unites the most beautiful flowers from all over the world:Ylang-Ylang, with its fruity and exotic notesDamascus Rose from Turkey, sensitive and smooth Jasmine Grandiflorum from Grasse, with Apricot and jam notes Indian Sambac Jasmine, with the warm facets of Orange Blossom Indian Tuberose, with its white, heady beauty.''',
  ),

  PerfumeModel(
    image: 'assets/images/12.jpeg',
    name: 'Good Girl Eau de Parfum',
    price: 142,
    category: 'Women',
    isFav: false,
    description:
        '''Uniquely designed packaging in the shape of a delicate high heel shoe, for every attractive woman.A perfect feminine blend of jasmine, rum and cocoa with almond and coffee to give you a sense of sensuality and vitality.''',
  ),

  PerfumeModel(
    image: 'assets/images/13.jpeg',
    name: 'Paradoxe Eau De Parfum',
    price: 113,
    category: 'Women',
    isFav: false,
    description:
        '''This feminine, floral perfume for women is an invitation to explore and express the paradoxical multidimensions of women.Experience the celebration of self-expression and the liberation that comes with being never the same, always yourself. This product is a bestseller.''',
  ),

  PerfumeModel(
    image: 'assets/images/14.jpeg',
    name: 'COCO MADEMOISELLE',
    price: 164,
    category: 'Women',
    isFav: false,
    description:
        '''COCO MADEMOISELLE Eau de Parfum Intense. The essence of a free and captivating woman.A woody and ambery oriental fragrance with a full-bodied character: sensual, deep and addictive.''',
  ),

  PerfumeModel(
    image: 'assets/images/15.jpeg',
    name: 'L Instant Magic Eau de Parfum',
    price: 184,
    category: 'Women',
    isFav: false,
    description:
        '''Rose, White Musks, Wood of Almond L'Instant Magic transports you to a dream world.With its immediately identifiable scent, it illustrates the instant when a dream suddenly becomes possible.L’Instant Magic is a light, soft fragrance, a mist that caresses on a bed of wood and musk.''',
  ),

  PerfumeModel(
    image: 'assets/images/16.jpeg',
    name: 'Ombré Leather',
    price: 248,
    category: 'Packages',
    isFav: false,
    description:
        '''Ombré Leather fragrance evokes the American west’s desert beauty with rich, black leather layered beneath patchouli, vetiver and jasmine sambac.''',
  ),

  PerfumeModel(
    image: 'assets/images/17.jpeg',
    name: 'Jadore',
    price: 252,
    category: 'Packages',
    isFav: false,
    description:
        '''The J'adore set consists of: J'adore Eau de Parfum (100 ml),Refillable travel spray (10 ml capacity).''',
  ),

  PerfumeModel(
    image: 'assets/images/18.jpeg',
    name: 'Gentleman Réserve Privée',
    price: 178,
    category: 'Packages',
    isFav: false,
    description:
        '''Honor your loved one with Gentleman Givenchy gift set, that includes an Eau de Parfum Réserve Privée, a shower gel, and a travel spray.''',
  ),

  PerfumeModel(
    image: 'assets/images/19.jpeg',
    name: 'Paradoxe Eau de Parfum Set',
    price: 164,
    category: 'Packages',
    isFav: false,
    description:
        '''A floral ambery fragrance that embraces the paradoxes of iconic ingredients to reveal new scented sensations.''',
  ),

  PerfumeModel(
    image: 'assets/images/20.jpeg',
    name: 'Idole Eau de Parfum',
    price: 157,
    category: 'Packages',
    isFav: false,
    description:
        '''Idole Eau de Parfum - 50ml Idole Body Lotion - 50ml Lash Idole Mascara Mini - 2.5ml.''',
  ),

   PerfumeModel(
    image: 'assets/images/21.jpeg',
    name: 'Miss Dior Blooming Bouquet',
    price: 74,
    category: 'Hair',
    isFav: false,
    description:
        '''Hair Mist features the light, refreshing character of its namesake fragrance.''',
  ),

  PerfumeModel(
    image: 'assets/images/22.jpeg',
    name: 'Good Girl Eau De Parfum 2',
    price: 64,
    category: 'Hair',
    isFav: false,
    description:
        '''Fragrance Family Oriental Floral Tuberose, Jasmine Sambac, and Tonka beans.''',
  ),

  PerfumeModel(
    image: 'assets/images/23.jpeg',
    name: 'GABRIELLE CHANEL',
    price: 92,
    category: 'Hair',
    isFav: false,
    description:
        '''GABRIELLE CHANEL Hair Mist highlights the luminous floral notes of the fragrance.''',
  ),

  PerfumeModel(
    image: 'assets/images/24.jpeg',
    name: 'YSL Libre Hairmist 2',
    price: 77,
    category: 'Hair',
    isFav: false,
    description:
        '''Spray the fragrance on the pulse points i.e. your neck and wrists, they emanate heat that helps the fragrance project from your skin for a longer-lasting, stronger scent.''',
  ),

  PerfumeModel(
    image: 'assets/images/25.jpeg',
    name: 'CHANCE EAU TENDRE',
    price: 92,
    category: 'Hair',
    isFav: false,
    description:
        '''The hair mist fragrances the hair with the floral-fruity notes of CHANCE EAU TENDRE.''',
  ),

  PerfumeModel(
    image: 'assets/images/26.jpeg',
    name: 'N°5',
    price: 73,
    category: 'Body',
    isFav: false,
    description:
        '''A wave of freshness that carries the feminine and sensual notes of N°5. This deodorant spray is the subtle finishing touch to the perfuming ritual.''',
  ),

  PerfumeModel(
    image: 'assets/images/27.jpeg',
    name: 'Rose Prick ',
    price: 179,
    category: 'Body',
    isFav: false,
    description:
        '''A fragrance that presents Bulgarian rose and rose de mai pierced with thorns of fiery pepper and spice, while Indonesian patchouli exhales around Turkish rose‘s precious heart.''',
  ),

  PerfumeModel(
    image: 'assets/images/28.jpeg',
    name: 'DEODORANT SPRAY',
    price: 72,
    category: 'Body',
    isFav: false,
    description:
        '''A deodorant with the floral notes of CHANCE. A light and fresh veil that provides instant comfort and well-being, leaving the skin delicately fragranced.''',
  ),

  PerfumeModel(
    image: 'assets/images/29.jpeg',
    name: 'Spray & Mist',
    price: 95,
    category: 'Body',
    isFav: false,
    description:
        '''Freedom Comes From Within, The Desert Heart Of The West Wrapped In Leather. It Moves Forward, Untethered, Through The Still Air Of Wide-Open Space.''',
  ),

  PerfumeModel(
    image: 'assets/images/30.jpeg',
    name: 'Deodorant Spray ',
    price: 95,
    category: 'Body',
    isFav: false,
    description:
        '''This scented deodorant offers protection and freshness throughout the day. Its very gentle formula, enriched with rose extract, protects the skin durably.''',
  ),

  PerfumeModel(
    image: 'assets/images/31.jpeg',
    name: 'Coco Mademoiselle',
    price: 170,
    category: 'Body',
    isFav: false,
    description:
        '''Coco Mademoiselle Pearly Body Oil is a shimmering, scented oil that gives skin a beautiful glow and awakens the senses.''',
  ),
];
