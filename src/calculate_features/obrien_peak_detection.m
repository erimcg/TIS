%
% Written by Tayseer O'Brien
%
% Based on ecddemowinmax.m by Sergey Chernenko: S.Chernenko@librow.com
%

function Filtered=obrien_peak_detection(Original, WinSize)
    currentMax = Original(1);
    currentMaxIndex = 1;

    for elementIndex = 2:1:WinSize
        if Original(elementIndex) > currentMax
            currentMax = Original(elementIndex);
            currentMaxIndex = elementIndex;
        end
        if elementIndex == WinSize
            Filtered(currentMaxIndex) = currentMax;
        end
    end

    endOfExecution = false;

    while endOfExecution == false
        tempLeftMax = currentMax;
        tempLeftMaxIndex = currentMaxIndex;
        leftBiggerValueDetected = false;
        keepLeft = false;
        for leftCheckIndex = 1:1:(WinSize - 1)
            if currentMaxIndex - (leftCheckIndex) > 0
                if Original(currentMaxIndex - leftCheckIndex) > tempLeftMax
                    tempLeftMax = Original(currentMaxIndex - leftCheckIndex);
                    tempLeftMaxIndex = currentMaxIndex - leftCheckIndex;
                    leftBiggerValueDetected = true;
                elseif Original(currentMaxIndex - leftCheckIndex) == tempLeftMax
                    tempLeftMax = Original(currentMaxIndex - leftCheckIndex);
                    keepLeft = true;
                    leftBiggerValueDetected = true;
                else
                    Filtered(currentMaxIndex - leftCheckIndex) = 0;
                end
            end
        end

        if leftBiggerValueDetected == false
            tempLeftMax = 0;
        end

        tempRightMax = currentMax;
        tempRightMaxIndex = currentMaxIndex;
        keepRight = false;
        rightBiggerValueDetected = false;
        nextWindowCheck = 0;
        reachedEndOfWindow = false;
        for rightCheckIndex = 1:1:(WinSize - 1)
            if(currentMaxIndex + rightCheckIndex) <= length(Original)
                if Original(currentMaxIndex + rightCheckIndex) > tempRightMax
                    tempRightMax = Original(currentMaxIndex + rightCheckIndex);
                    tempRightMaxIndex = currentMaxIndex + rightCheckIndex;
                    rightBiggerValueDetected = true;
                elseif Original(currentMaxIndex + rightCheckIndex) == tempRightMax
                    tempRightMaxIndex = currentMaxIndex + rightCheckIndex;
                    keepRight = true;
                    rightBiggerValueDetected = true;
                else
                    Filtered(currentMaxIndex + rightCheckIndex) = 0;
                end

                if(rightCheckIndex == WinSize - 1)
                    if((currentMaxIndex + (rightCheckIndex + 1)) < (length(Original)+1))
                        reachedEndOfWindow = true;
                        moveWindowIndex = currentMaxIndex + (rightCheckIndex + 1);
                    end
                end
            else
                endOfExecution = true;
            end
        end

        if(rightBiggerValueDetected == false)
            tempRightMax = 0;
        end

        if(tempRightMax > tempLeftMax)
            if(keepRight == false)
                Filtered(currentMaxIndex) = 0;
                Filtered(tempRightMaxIndex) = tempRightMax;
                currentMax = tempRightMax;
                currentMaxIndex = tempRightMaxIndex;
            else
                Filtered(tempRightMaxIndex) = tempRightMax;
                currentMax = tempRightMax;
                currentMaxIndex = tempRightMaxIndex;
            end

        elseif(tempRightMax == tempLeftMax)
            if(tempRightMax == 0 && (tempRightMax == currentMax))
                Filtered(tempRightMaxIndex) = tempRightMax;
                currentMax = tempRightMax;
                currentMaxIndex = tempRightMaxIndex;
            else
                for checkerIndex = 1:1:WinSize - 1
                    if (tempLeftMaxIndex - checkerIndex > 0) && Filtered(tempLeftMaxIndex - checkerIndex) > 0
                        Filtered(tempLeftMaxIndex) = 0;
                        Filtered(currentMaxIndex) = 0;
                        Filtered(tempRightMaxIndex) = tempRightMax;
                        currentMax = tempRightMax;
                        currentMaxIndex = tempRightMaxIndex;
                    end
                    %%%%%% ELSE   %%%%%% ADD BOTH MAXES IF THE LEFT IS NOT IN BOUNDARY
                end
            end
        else
            detected = false;
            if(keepLeft == false) %not same as currentMax
                for checkerIndex = 1:1:WinSize - 1
                    if (tempLeftMaxIndex - checkerIndex > 0) && Filtered(tempLeftMaxIndex - checkerIndex) > 0
                        if(Filtered(tempLeftMaxIndex - checkerIndex) ~= Original(tempLeftMaxIndex))
                            detected = true;
                            if(tempRightMax == 0)
                                %keep CurrentMax
                                Filtered(currentMaxIndex) = currentMax;
                            elseif(tempRightMax > 0)
                                Filtered(tempLeftMaxIndex) = 0;
                                % Then make the right the new currentMax!
                                Filtered(currentMaxIndex) = 0;
                                Filtered(tempRightMaxIndex) = tempRightMax;
                                currentMax = tempRightMax;
                                currentMaxIndex = tempRightMaxIndex;
                            end
                        end
                    end
                end
                %%%% IF ITS NOT IN BOUNDARY THEN MAKE LEFT THE NEW CURRENTMAX
                if(detected == false)
                    Filtered(tempRightMaxIndex) = 0;
                    Filtered(currentMaxIndex) = 0;
                    Filtered(tempLeftMaxIndex) = tempLeftMax;
                    currentMax = tempLeftMax;
                    currentMaxIndex = tempLeftMaxIndex;
                end
            else
                Filtered(tempLeftMaxIndex) = tempLeftMax;
                currentMax = tempLeftMax;
                currentMaxIndex = tempLeftMaxIndex;
            end
        end

        if endOfExecution == false
            nextWindowCheck = Original(moveWindowIndex);
            currentMax = nextWindowCheck;
            currentMaxIndex = moveWindowIndex;
        end
    end
end

