class Parser {

  ArrayList<Bloc> tabBloc;
  int count=0;

  Parser(PShape p) {
    //On récupère les dimensions du fond
    width_world=int(p.width);
    height_world=int(p.height);

    tabBloc = new ArrayList<Bloc>();

    for (int i=0; i<p.getChildCount(); i++) {
      PShape s = p.getChild(i);
      if (s.getKind() == RECT ) {
        float [] param = s.getParams();
        tabBloc.add(new Bloc(param[0], param[1], param[2], param[3]));
        count++;
      }
    }
  }

  void draw() {
    for (int i=0; i<tabBloc.size(); i++) {
      tabBloc.get(i).draw();
    }
  }

}