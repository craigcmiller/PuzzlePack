// board square states
#define EMPTY	0
#define CROSS	1
#define CIRCLE	2


@interface TicTacToe : NSObject
{
}

- (instancetype)init NS_DESIGNATED_INITIALIZER;

/* Create a new game starting with nots or crosses */
- (void)newGame:(NSInteger)startingSide;

/* Draw board to standard out (for debug) */
- (void)drawBoardToSO;

/* Make a move at square. Returns YES if move is allowed */
- (BOOL)addMove:(NSInteger)square;

/* Change the active side */
- (void)changeCurrentSide;

/* YES if the game has been won */
@property (NS_NONATOMIC_IOSONLY, readonly) BOOL won;

/* Get the winning player */
@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger winner;

/* Get the currently active side */
@property (NS_NONATOMIC_IOSONLY, getter=getCurrentSide, readonly) NSInteger currentSide;

/* Get a pointer to the board */
@property (NS_NONATOMIC_IOSONLY, getter=getCurrentBoard, readonly) NSInteger *currentBoard;

/* Get the computer to make a move */
- (void)compMove;

/* Add a computer move at move or somewhere else if this is not possible */
- (void)addCompMove:(NSInteger)move;

/* Returns a location to place a piece where a win is guarenteed */
- (int)canWinAt:(NSInteger)side;

/* Get the number of the current move */
@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger moveNumber;

@end
