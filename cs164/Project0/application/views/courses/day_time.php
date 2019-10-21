<?php echo validation_errors(); ?>

<?php echo form_open('courses/list_courses_by_day_time') ?>

        <fieldset data-role="controlgroup" data-type="horizontal">

            <legend>Search courses by day and time</legend>
            
            <label for="day">Day</label>

            <select name="day" id="_day">
                <option value="#" disabled>Weekday</option>
                <option value="1">Monday</option>
                <option value="2">Tuesday</option>
                <option value="3">Wednesday</option>
                <option value="4">Thursday</option>
                <option value="5">Friday</option>
            </select>

        </fieldset>

        <fieldset data-role="controlgroup" data-type="horizontal">

            <legend>From:</legend>
            
            <label for="hour1">Time-Hour</label>

            <select name="hour1" id="_hour1">
                <option value="#" disabled>hh</option>
                <?php 
                    for($i = 0; $i < 24; $i++) {
                        if ($i >= 0 && $i <= 9)
                            echo '<option value='.'"'.'0'.$i.'"'.'>'.'0'.$i.'</option>';
                        else
                            echo '<option value='.'"'.$i.'"'.'>'.$i.'</option>';
                    }
                ?>
            </select> 

            <label for="minute1">Time-Minutes</label>

            <select name="minute1" id="_minute1">
                <option value="#" disabled>mm</option>
                <option value="00">00</option>
                <option value="30">30</option>
            </select>

        </fieldset>

        <legend>To:</legend>

        <fieldset data-role="controlgroup" data-type="horizontal">

            <label for="hour2">Time-Hour</label>

            <select name="hour2" id="_hour2">
                <option value="#" disabled>hh</option>
                <?php 
                    for($i = 0; $i < 24; $i++) {
                        if ($i >= 0 && $i <= 9)
                            echo '<option value='.'"'.'0'.$i.'"'.'>'.'0'.$i.'</option>';
                        else
                            echo '<option value='.'"'.$i.'"'.'>'.$i.'</option>';
                    }
                ?>
            </select> 

            <label for="minute2">Time-Minutes</label>

            <select name="minute2" id="_minute2">
                <option value="#" disabled>mm</option>
                <option value="00">00</option>
                <option value="30">30</option>
            </select>

        </fieldset>

        <input type="submit" name="submit" value="Submit" />

</form>