final List<String> categories = [
  'All',
  'Men',
  'Women',
  'Packages',
  'Kids'
  'Top',
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
];
