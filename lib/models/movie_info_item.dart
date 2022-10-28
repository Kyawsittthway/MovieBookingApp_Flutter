class MovieInfo {
   String movieName;
   String movieFormat;
   String moviePlace ;
   String movieTicketAmount;
   String movieSeat;
   String movieScreen;

  MovieInfo

  ({
   required this.movieName,
    required this.movieFormat,
   required this.moviePlace,
   required this.movieTicketAmount,
    required this.movieSeat,
    required this.movieScreen

  });
}
MovieInfo movieInfo = MovieInfo(movieName: "Emily",movieFormat: "(3D) (U/A)", moviePlace: "JCGV : Junction City", movieTicketAmount: "M-Ticket(1)",movieSeat: "Gold-G7,G8",movieScreen:"(SCREEN2)" );